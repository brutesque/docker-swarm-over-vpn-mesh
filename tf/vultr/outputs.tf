locals {
  instances = zipmap(vultr_instance.instances.*.hostname, vultr_instance.instances.*.main_ip)
}

resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/vultr"
  content  = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
}

output "instances" {
  value = local.instances
}
