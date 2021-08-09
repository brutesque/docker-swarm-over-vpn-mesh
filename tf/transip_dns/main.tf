data "transip_domain" "primary" {
  for_each = toset(compact(var.domain_names))
  name     = each.key
}

locals {
  domain_names = values(data.transip_domain.primary)[*].name
}

resource "transip_dns_record" "entrypoints" {
  count   = length(local.domain_names)
  domain  = local.domain_names[count.index]
  name    = format("*.%s", var.subdomain)
  type    = "A"
  content = var.entrypoints
  expire  = 300
}

resource "transip_dns_record" "leader" {
  count   = length(local.domain_names)
  domain  = local.domain_names[count.index]
  name    = format("leader.%s", var.subdomain)
  type    = "A"
  content = [var.leader]
  expire  = 300
}
