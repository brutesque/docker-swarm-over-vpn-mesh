# Ansible playbook for Docker Swarm using Tinc
This terraform/ansible project creates a Docker Swarm that uses a Tinc vpn-mesh for private communication between nodes. 
The goal is to have a working swarm that has nodes across geolocations and across providers.

When using the makefile to deploy, the following will happen:
- Terraform will use the configuration files in the tf/ folder to spin up a number of vps instances.
- An ansible inventory is dynamically created by terraform, as well a vars.yml for the ansible-playbook to use.
- All nodes get some initial hardening. A user will be created using the local $USER env variable.
- Node ip-addresses are linked to DuckDNS subdomains, if configured.
- A tinc vpn mesh will be created between all the nodes.
- Glusterfs will be set up for replicated storage across nodes over the tinc vpn mesh.
- Docker Swarm will be set up to use the tinc vpn mesh for communication between swarm nodes.
- Initial admin stacks are deployed on the swarm and will be made available through reverse-proxy.

Requirements:
- Terraform 0.14
- Python-pip

Implemented providers:
- Digital Ocean
- Oracle Cloud Infrastructure
- Vultr
- DuckDNS

### Execute deployment

Setup a CNAME record in your domain registrars dns records pointed to your duckdns subdomain. The domain name will be used for all swarm services. Using duckdns links the domain dynamically to the swarm's ip address.
```
name: *
type: CNAME
value: my-duckdns-subdomain.duckdns.org.
```
Make sure to include the dot at the end.

- Create and populate the providers.tfvars with credentials from your providers. See providers.tfvars.example.
- Copy config.tfvars.example to config.tfvars and adjust swarm settings to your liking.

Run:
```
$ make deploy
```

### Backups

Backup your certs to the local secrets/backups folder by running:
```
$ make backup
```
These certs will get automatically restored on the next deployment if the configured domain_name matches.

### Destroy deployment

To destroy the swarm run:
```
$ make destroy
```
Before destroying the nodes, the backup process for the certs will run.
If the backup process fails (possibly by interupting deployment process), the nodes won't be destroyed. In that case run:
```
make force-destroy
```

Additionally to remove any local temporary files (terraform data, ansible data, etc), run:
```
$ make clean
```

### Use admin apps

After succesful deployment, you can browse to the following admin interfaces (if configured):

- Portainer: portainer.admin.your-domain.com
- Traefik: traefik.admin.your-domain.com
- Registry: registry.your-domain.com
- Swarmpit: swarmpit.admin.your-domain.com
- Swarmprom:
    - grafana.admin.your-domain.com
    - prometheus.admin.your-domain.com
    - unsee.admin.your-domain.com
    - alertmanager.admin.your-domain.com

### Todo
- Overwrite any passwords generated by the provider at vps creation
- Set "PermitRootLogin no" after becoming different user in playbook
- Don't allow ssh as root; implement ansible user that becomes root
- Check docker services and implement non-root user where possible
- Tls verification for docker? (assuming this is not applicable since this already uses tinc vpn)
- Figure out a better way for storing terraform secrets, other than environment variables. Preferably some kind of vault
- Use ansible vault for secrets (if still applicable after terraform secrets method)
- Use chronyd to synchronize time between nodes
- implement bastion (ssh and vpn) for secure acces to nodes and admin services
- Configure Tinc nodes to use private networking, if made available by the provider. Minimizes data cost.
- Create upgrade playbook, that safely drains an upgraded node before it reboots it.
- Check deployment logs thoroughly and make sure sensitive data is being masked
