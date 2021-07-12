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
  name    = "@"
  type    = "A"
  content = var.entrypoints
  expire  = 60
}

resource "transip_dns_record" "service_subdomains" {
  count   = length(local.domain_names)
  domain  = local.domain_names[count.index]
  name    = format("*.%s", var.subdomain)
  type    = "CNAME"
  content = ["@"]
  expire  = 60
}
