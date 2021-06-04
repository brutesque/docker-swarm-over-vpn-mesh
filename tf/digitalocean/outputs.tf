locals {
  instances = zipmap(digitalocean_droplet.instances.*.name, digitalocean_droplet.instances.*.ipv4_address)
}

resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/digitalocean"
  content  = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
}

output "instances" {
  value = local.instances
}
