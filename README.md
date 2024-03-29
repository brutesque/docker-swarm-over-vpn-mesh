# Ansible playbook for Docker Swarm using Tinc
This terraform/ansible project creates a Docker Swarm that uses a Tinc vpn-mesh for private communication between nodes. 
The goal is to have a working swarm that has nodes across geo-locations using multiple providers.

When using the makefile to deploy, the following will happen:
- Terraform will use the configuration files in the tf/ folder to spin up a number of vps instances.
- Terraform will spin up a number of vps instances as configured in secrets/config.tfvars
- Terraform will add a subdomain with wildcard for children to the DNS records of supplied domains 
- An ansible inventory is dynamically created by terraform, as well a vars.yml for the ansible-playbook to use.
- All nodes get some initial hardening. A user will be created using the local $USER env variable.
- Node ip-addresses are linked to DuckDNS subdomains, if configured.
- A tinc vpn mesh will be created between all the nodes.
- Glusterfs will be set up for replicated storage across nodes over the tinc vpn mesh.
- Docker Swarm will be set up to use the tinc vpn mesh for communication between swarm nodes.
- Initial admin stacks are deployed on the swarm and will be made available through reverse-proxy.

Requirements:
- Terraform 0.15.3
- Python-pip

Implemented instance providers:
- Digital Ocean
- Hetzner Cloud
- Oracle Cloud Infrastructure
- TransIP
- Vultr
- On-premise

Implemented dns providers:
- Cloudflare
- DuckDNS
- TransIP

### Prepare deployment

```
$ git clone https://github.com/brutesque/docker-swarm-over-vpn-mesh.git
$ cd docker-swarm-over-vpn-mesh/
```

- Copy secrets/credentials.tfvars.example to secrets/credentials.tfvars and populate the credentials for your providers.
- Copy tf/modules.tf.example to tf/modules.tf and comment out the providers you haven't configured credentials for.
- Copy secrets/config.tfvars.example to secrets/config.tfvars and adjust swarm settings to your liking.

If you have a domain that you want to manually setup to connect to the swarm, add a CNAME in your DNS records pointed to 
the first of your configured duckdns subdomains. Add your domain to the manual_domains list in config.tfvars. Make sure
that the new subdomain matches the services_subdomain variable in config.tfvars. Swarm services will be published under
this subdomain.

```
name: *.swarm
type: CNAME
value: my-duckdns-subdomain.duckdns.org.
```
Make sure to include the wildcard in the name field and the dot at the end of the value field.

### Execute deployment

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


If the ansible backup playbook fails (usually caused by an interupted deployment playbook), terraform won't destroy the running instances. In that case run:
```
make terraform-destroy
```

Remove any local temporary files, run:
```
$ make clean
```

### Use admin apps and test stacks

After succesful deployment, you can access the admin services the you have enabled in the config.tfvars. The services are
available at [https://service-name.services-subdomain.your-domain.com/](), eg. [https://portainer.swarm.brandx.com]()
and also at [https://portainer.swarm.your-duckdns-subdomain.duckdns.org]() if you've configured DuckDNS subdomains.
At the end of the  ansible playbook, all available urls will be printed to screen.

You can also manually run the ansible task to print the urls to screen again:
```
ansible-playbook playbook-deploy --tag urls
```
