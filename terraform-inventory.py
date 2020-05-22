#!/usr/bin/env python

import collections
import json
import os
import sys
import traceback
from subprocess import Popen, PIPE


def dict_merge(dct, merge_dct):
    """ Recursive dict merge. Inspired by :meth:``dict.update()``, instead of
    updating only top-level keys, dict_merge recurses down into dicts nested
    to an arbitrary depth, updating keys. The ``merge_dct`` is merged into
    ``dct``.
    :param dct: dict onto which the merge is executed
    :param merge_dct: dct merged into dct
    :return: None
    """
    for k, v in merge_dct.items():
        if (k in dct and isinstance(dct[k], dict)
                and isinstance(merge_dct[k], collections.Mapping)):
            dict_merge(dct[k], merge_dct[k])
        else:
            dct[k] = merge_dct[k]


def _get_inventory():
    ANSIBLE_PATH = 'ansible-inventory'
    ANSIBLE_DIR = os.getcwd()

    encoding = 'utf-8'
    ansible_command = [ANSIBLE_PATH, '--list', '--inventory', 'secrets/hosts']
    proc_tf_cmd = Popen(ansible_command, cwd=ANSIBLE_DIR, stdout=PIPE, stderr=PIPE, universal_newlines=True)
    out_cmd, err_cmd = proc_tf_cmd.communicate()
    if err_cmd != '':
        sys.stderr.write(str(err_cmd) + '\n')
        sys.exit(1)
    else:
        return json.loads(out_cmd, encoding=encoding)


def _execute_shell():
    TERRAFORM_PATH = 'terraform'
    TERRAFORM_DIR = os.getcwd()

    encoding = 'utf-8'
    tf_workspace = [TERRAFORM_PATH, 'workspace', 'select', 'default']
    proc_ws = Popen(tf_workspace, cwd=TERRAFORM_DIR, stdout=PIPE, stderr=PIPE, universal_newlines=True)
    _, err_ws = proc_ws.communicate()
    if err_ws != '':
        sys.stderr.write(str(err_ws) + '\n')
        sys.exit(1)
    else:
        tf_command = [TERRAFORM_PATH, 'state', 'pull']
        proc_tf_cmd = Popen(tf_command, cwd=TERRAFORM_DIR, stdout=PIPE, stderr=PIPE, universal_newlines=True)
        out_cmd, err_cmd = proc_tf_cmd.communicate()
        if err_cmd != '':
            sys.stderr.write(str(err_cmd) + '\n')
        else:
            return json.loads(out_cmd, encoding=encoding)


def _main():
    try:
        tfstate = _execute_shell()
        inventory = {
            "_meta": {
                "hostvars": {}
            },
            "all": {
                "children": [
                    "managers",
                    "workers",
                    "servers",
                    "vpn_mesh",
                    "ungrouped"
                ]
            },
            "vpn_mesh": {
                "hosts": []
            },
            "entrypoints": {
                "hosts": []
            },
            "managers": {
                "hosts": []
            },
            "workers": {
                "hosts": []
            },
            "servers": {
                "hosts": [],
            }
        }
        dict_merge(inventory, _get_inventory())
        vpn_ips = [x['vpn_ip'] for x in inventory['_meta']['hostvars'].values() if 'vpn_ip' in x]
        if len(vpn_ips) > 0:
            vpn_ip_first_part = '.'.join(vpn_ips[0].split('.')[0:3])
            i = max([int(x.split('.')[-1]) for x in vpn_ips]) + 1
        else:
            vpn_ip_first_part = '10.0.0'
            i = 1
        managers = 1
        for resource in tfstate['resources']:
            if resource['type'] in ['digitalocean_droplet', 'vultr_server']:
                try:
                    resource_vpn_ip = inventory['_meta']['hostvars'][resource['name']]['vpn_ip']
                except KeyError:
                    resource_vpn_ip = "{}.{}".format(vpn_ip_first_part, i)
                    i += 1
                finally:
                    if resource['type'] == 'digitalocean_droplet':
                        ansible_host = resource['instances'][0]['attributes']['ipv4_address']
                    elif resource['type'] == 'vultr_server':
                        ansible_host = resource['instances'][0]['attributes']['main_ip']
                    dict_merge(
                        inventory['_meta']['hostvars'],
                        {
                            resource['name']: {
                                'ansible_host': ansible_host,
                                'ansible_python_interpreter': "/usr/bin/python3",
                                'ansible_user': "root",
                                'vpn_ip': resource_vpn_ip,
                                'wan_interface': "eth0"
                            }
                        }
                    )
                    for group in ['servers', 'vpn_mesh']:
                        if resource['name'] not in inventory[group]['hosts']:
                            inventory[group]['hosts'].append(resource['name'])

                    if len(inventory['managers']['hosts']) < managers:
                        if resource['name'] not in inventory['managers']['hosts']:
                            inventory['managers']['hosts'].append(resource['name'])
                    else:
                        if resource['name'] not in inventory['workers']['hosts']:
                            inventory['workers']['hosts'].append(resource['name'])


        sys.stdout.write(json.dumps(inventory, indent=2))
    except Exception:
        traceback.print_exc(file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    _main()
