resource "local_file" "AnsibleInventory" {
  content = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = var.instances,
    }
  )
  filename = "../secrets/inventory/onpremise"
}

output "instances" {
  value = var.instances
}
