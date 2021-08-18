locals {
  instances = zipmap(hcloud_server.instances.*.name, hcloud_server.instances.*.ipv4_address)
}

resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/hetzner"
  content  = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
}

output "instances" {
  value = local.instances
}
