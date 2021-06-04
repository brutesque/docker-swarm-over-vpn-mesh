resource "local_file" "AnsibleInventory" {
  filename = "../secrets/inventory/onpremise"
  content  = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = var.instances,
    }
  )
}

output "instances" {
  value = var.instances
}
