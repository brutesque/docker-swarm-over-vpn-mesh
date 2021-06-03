locals {
  all_instances = zipmap(flatten([for hosts in values(local.instances) : keys(hosts)]), flatten([for hosts in values(local.instances) : values(hosts)]))

  manager_candidates  = [
    for provider in keys(local.instances) : keys(local.instances[provider])
    if contains(var.manager_providers, provider)
  ]
  max_length = max([for provider in keys(local.instances) : length(local.instances[provider])]...)
  manager_selection_order = distinct(flatten([
    for i in range(local.max_length) : [for hosts in local.manager_candidates : element(hosts, i)
    if length(hosts) > 0]
  ]))
  docker_managers = slice(local.manager_selection_order, 0, min(3, length(local.manager_selection_order)))
  docker_workers  = setsubtract(keys(local.all_instances), local.docker_managers)

  entrypoints     = slice(keys(local.all_instances), 0, min(5, length(local.all_instances)))
  glusterpool     = keys(local.all_instances)
  duckdns_subdomains = var.duckdns_subdomains
}

### Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("ansible-inventory.tmpl",
    {
      all-instances      = local.all_instances,
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
