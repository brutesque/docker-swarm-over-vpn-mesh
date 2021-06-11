locals {
  merged_instances        = merge(values(local.instances)...)

  manager_candidates      = [for provider in keys(local.instances) : keys(local.instances[provider]) if contains(var.manager_providers, provider)]

  max_length              = max([for provider in keys(local.instances) : length(local.instances[provider])]...)
  manager_selection_order = distinct(flatten([for i in range(local.max_length) : [for hosts in local.manager_candidates : element(hosts, i) if length(hosts) > 0]]))
  docker_managers         = slice(local.manager_selection_order, 0, min(3, length(local.manager_selection_order)))
  docker_workers          = setsubtract(keys(local.merged_instances), local.docker_managers)

  entrypoints             = slice(keys(local.merged_instances), 0, min(5, length(local.merged_instances)))
  glusterpool             = keys(local.merged_instances)
}

### Ansible inventory file
resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/hosts"
  content  = templatefile("ansible-inventory.tmpl",
    {
      all-instances      = local.merged_instances,
      docker-managers    = local.docker_managers,
      docker-workers     = local.docker_workers,
      entrypoints        = local.entrypoints,
      glusterpool        = local.glusterpool,
      duckdns-subdomains = var.duckdns_subdomains,
    }
  )
}

### Ansible vars file
resource "local_file" "AnsibleVars" {
  filename = "../secrets/vars.yml"
  content  = templatefile("ansible-vars.tmpl",
    {
      duckdns_token    = var.duckdns_token,
      ssh_public_key   = file(var.ssh_public_key_path),
      domain_name      = var.domain_name,
      swarm_subdomain  = var.swarm_subdomain,
      project_name     = var.project_name,
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
}

output "instances" {
  value = local.merged_instances
}
