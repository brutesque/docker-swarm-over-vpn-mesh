locals {
  instances = zipmap(oci_core_instance.instances.*.hostname_label, oci_core_instance.instances.*.public_ip)
}

resource "local_file" "AnsibleInventory" {
  content  = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
  filename = "../secrets/inventory/oraclecloud"
}

output "instances" {
  value = local.instances
}
