resource "transip_sshkey" "deploy" {
  count       = length(compact([var.ssh_public_key_path]))
  description = format("Deploy: %s", var.project_name)
  key         = trimspace(file(var.ssh_public_key_path))
}

data "transip_vps" "instances" {
  for_each = toset(compact(var.instance_names))
  name     = each.key
}

resource "transip_vps" "instances" {
  count            = var.instance_count
  description      = format("tip-instance-%02d", count.index + 1 + length(var.instance_names))
  product_name     = "vps-bladevps-x1"
  operating_system = "ubuntu-20.04"
}
