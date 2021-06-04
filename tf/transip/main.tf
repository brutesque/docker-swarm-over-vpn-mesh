
data "transip_vps" "instances" {
  for_each = toset( var.instance_names )
  name     = each.key
}

resource "transip_vps" "instances" {
  count            = var.instance_count
  description      = format("tip-instance-%02d", count.index + 1 + length(var.instance_names))
  product_name     = "vps-bladevps-x1"
  operating_system = "ubuntu-20.04"
}
