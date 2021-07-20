locals {
  glusterpool        = local.selection_order

  duckdns_candidates = distinct(concat(local.entrypoints, local.managers, local.workers))
  duckdns_hosts      = zipmap(
    slice(local.duckdns_candidates, 0, min(length(local.duckdns_candidates), length(var.duckdns_subdomains))),
    slice(var.duckdns_subdomains, 0, min(length(local.duckdns_candidates), length(var.duckdns_subdomains))),
  )
}

### Ansible inventory file
resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/hosts"
  content  = templatefile("ansible-inventory.tmpl",
    {
      instances     = local.merged_instances,
      managers      = local.managers,
      workers       = local.workers,
      entrypoints   = local.entrypoints,
      glusterpool   = local.glusterpool,
      duckdns_hosts = local.duckdns_hosts,
    }
  )
}

### Ansible vars file
resource "local_file" "AnsibleVars" {
  filename = "../secrets/vars.yml"
  content  = templatefile("ansible-vars.tmpl",
    {
      ssh_public_key     = file(var.ssh_public_key_path),
      project_name       = var.project_name,
      domain_names       = local.merged_domain_names,
      services_subdomain = var.services_subdomain,
      duckdns_token      = var.duckdns_token,
      duckdns_hosts      = local.duckdns_hosts,
      entrypoints        = local.entrypoints,
      admin_password     = var.admin_password,
      admin_email        = var.admin_email,
      user_name          = var.user_name,
      user_password      = var.user_password,
      stacks_portainer   = var.stacks_portainer,
      stacks_swarmpit    = var.stacks_swarmpit,
      stacks_swarmprom   = var.stacks_swarmprom,
      stacks_tests       = var.stacks_tests,
    }
  )
}

output "instances" {
  value = local.merged_instances
}

output "domains" {
  value = local.merged_domain_names
}

output "managers" {
  value = local.managers
}

output "workers" {
  value = local.workers
}

output "entrypoints" {
  value = local.entrypoints
}

