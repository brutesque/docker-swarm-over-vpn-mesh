# Ansible playbook for Docker Swarm using Tinc
This ansible playbook sets up a Docker Swarm using Tinc for peer-to-peer communication between nodes.

Requirements:
- Terraform
- Python-pip

### Execute deployment

Setup a CNAME record in you domain dns pointed at your duckdns subdomain. The domain name will be used for all swarm services. Using duckdns links the domain dynamically to the swarm's ip address.
```
name: *
type: CNAME
value: my-duckdns-subdomain.duckdns.org.
```
Make sure to include the dot at the end.

- Create a hosts file in the secrets folder using hosts.default as a template.
- Adjust vps-instances.tf to your likings.

- Set the following environment variables:
    - DO_TOKEN: Digital Ocean API token
    - VULTR_TOKEN: Vultr API token
    - DUCKDNS_TOKEN: DuckDNS API token
    - ADMIN_PASSWORD: admin password for swarm services

Run:
```
$ make deploy
```

### Destroy deployment

Run:
```
$ make destroy
```

Additionally to remove any temporary files (terraform data, ansible data, etc), run:
```
$ make clean
```


#### Security todo:
- Set "PermitRootLogin no" after becoming different user in playbook
- don't allow ssh as root
- Setup services under non-root user
- block docker from adjusting iptables
- docker overlay network with encryption
- tls verification for docker

#### todo:
- create easy method to switch between development and production
- create method for persisting letsencrypt data between deployments (to prevent getting rate-limited)
- implement traefikv2
    - usersfile as secret
    - get traefik working on workers using limited docker socket
- clear duckdns record if vps using the ip address gets destroyed
