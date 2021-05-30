locals {
  instances       = {
    onpremise     = module.onpremise.instances,
    digitalocean  = module.digitalocean.instances,
    oraclecloud   = module.oraclecloud.instances,
    vultr         = module.vultr.instances,
  }
  all_instances   = merge(
          module.onpremise.instances,
          module.digitalocean.instances,
          module.oraclecloud.instances,
          module.vultr.instances,
  )
  docker_managers = slice(keys(local.all_instances), 0, min(var.manager_count, length(local.all_instances)))
  docker_workers  = slice(keys(local.all_instances), min(var.manager_count, length(local.all_instances)), length(local.all_instances))
  entrypoints     = slice(keys(local.all_instances), 0, min(5, length(local.all_instances)))
  glusterpool     = keys(local.all_instances)
  duckdns_subdomains = var.duckdns_subdomains
}

### Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("ansible-inventory.tmpl",
    {
      all-instances      = local.all_instances,
      prem-instances     = keys(local.prem_instances),
      docker-managers    = local.docker_managers,
      docker-workers     = local.docker_workers,
      entrypoints        = local.entrypoints,
      glusterpool        = local.glusterpool,
      duckdns-subdomains = local.duckdns_subdomains,
    }
  )
  filename = "../secrets/inventory/hosts"
}

### Ansible vars file
resource "local_file" "AnsibleVars" {
  content = templatefile("ansible-vars.tmpl",
    {
      duckdns_token    = var.duckdns_token,
      ssh_public_key   = file(var.ssh_public_key_path),
      domain_name      = var.domain_name,
      admin_password   = var.admin_password,
      admin_email      = var.admin_email,
      user_name        = var.user_name,
      user_password    = var.user_password,
      stacks_portainer = var.stacks_portainer,
      stacks_swarmpit  = var.stacks_swarmpit,
      stacks_swarmprom = var.stacks_swarmprom,
      stacks_tests     = var.stacks_tests,
    }
  )
  filename = "../secrets/vars.yml"
}

output "instances" {
  value = local.all_instances
}
