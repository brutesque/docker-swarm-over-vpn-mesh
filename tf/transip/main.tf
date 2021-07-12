resource "transip_sshkey" "deploy" {
  count       = length(compact([var.ssh_public_key_path]))
  description = format("Deploy: %s", var.project_name)
  key         = trimspace(file(var.ssh_public_key_path))
}

data "transip_vps" "instances" {
  for_each = toset(compact(var.existing_instances))
  name     = each.key
}

resource "transip_vps" "instances" {
  count            = length(var.instances)
  description      = format("tip-instance-%02d", count.index + 1 + length(var.existing_instances))
  product_name     = element(var.instances, count.index)
  operating_system = "ubuntu-20.04"
}
