locals {
  prem_instances = {}
  do_instances = zipmap(digitalocean_droplet.instances.*.name, digitalocean_droplet.instances.*.ipv4_address)
  oci_instances = zipmap(oci_core_instance.instances.*.hostname_label, oci_core_instance.instances.*.public_ip)
  vultr_instances = zipmap(vultr_instance.instances.*.hostname, vultr_instance.instances.*.main_ip)

  all_instances = merge(
          local.prem_instances,
          local.do_instances,
          local.oci_instances,
          local.vultr_instances,
  )

  docker_managers = slice(keys(local.all_instances), 0, min(2, length(local.all_instances)))
  docker_workers = slice(keys(local.all_instances), min(2, length(local.all_instances)), length(local.all_instances))
  entrypoints = slice(keys(local.all_instances), 0, min(5, length(local.all_instances)))
  glusterpool = keys(local.all_instances)
}

locals {
  duckdns_subdomains = var.duckdns_subdomains
}

### Ansible inventory file
resource "local_file" "AnsibleInventory" {
  content = templatefile("tf/ansible-inventory.tmpl",
    {
      all-instances = local.all_instances,
      prem-instances = keys(local.prem_instances),
      oci-instances = keys(local.oci_instances),
      do-instances = keys(local.do_instances),
      vultr-instances = keys(local.vultr_instances),
      docker-managers = local.docker_managers,
      docker-workers = local.docker_workers,
      entrypoints = local.entrypoints,
      glusterpool = local.glusterpool,
      duckdns-subdomains = local.duckdns_subdomains,
    }
  )
  filename = "secrets/inventory"
}

### Ansible vars file
resource "local_file" "AnsibleVars" {
  content = templatefile("tf/ansible-vars.tmpl",
    {
      duckdns_token = var.duckdns_token,
      ssh_public_key = file(var.ssh_public_key_path),
      domain_name = var.domain_name,
      admin_password = var.admin_password,
      admin_email = var.admin_email,
      user_password = var.user_password,
      stacks_portainer = var.stacks_portainer,
      stacks_swarmpit = var.stacks_swarmpit,
      stacks_swarmprom = var.stacks_swarmprom,
      stacks_tests = var.stacks_tests,
    }
  )
  filename = "secrets/vars.yml"
}

output "instances" {
  value = local.all_instances
}
