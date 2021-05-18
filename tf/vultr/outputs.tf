locals {
  instances = zipmap(vultr_instance.instances.*.hostname, vultr_instance.instances.*.main_ip)
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
  filename = "../secrets/inventory/vultr"
}

output "instances" {
  value = local.instances
}
