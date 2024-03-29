locals {
  instances = merge(
    length(data.transip_vps.instances) > 0 ? zipmap(values(data.transip_vps.instances)[*].description, values(data.transip_vps.instances)[*].ip_address) : {},
    length(transip_vps.instances) > 0 ? zipmap(transip_vps.instances[*].description, transip_vps.instances[*].ip_address) : {},
  )
}

resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/transip"
  content  = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
}

output "instances" {
  value = local.instances
}
