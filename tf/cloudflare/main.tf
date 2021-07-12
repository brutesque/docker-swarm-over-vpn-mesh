data "cloudflare_zones" "primary" {
  for_each = toset(compact(var.domain_names))
  filter {
    name   = each.key
  }
}

locals {
  zone_ids     = zipmap(
    values(data.cloudflare_zones.primary)[*].zones[0].name,
    values(data.cloudflare_zones.primary)[*].zones[0].id
  )
  entrypoints  = setproduct(values(local.zone_ids), var.entrypoints)
  subdomains   = setproduct(values(local.zone_ids), [var.subdomain])
  domain_names = keys(local.zone_ids)
}

resource "cloudflare_record" "entrypoints" {
  count    = length(local.entrypoints)
  zone_id  = local.entrypoints[count.index][0]
  name     = "@"
  type     = "A"
  value    = local.entrypoints[count.index][1]
  ttl      = 600
  proxied  = false
}

resource "cloudflare_record" "services_subdomains" {
  count    = length(local.subdomains)
  zone_id  = local.subdomains[count.index][0]
  name     = format("*.%s", local.subdomains[count.index][1])
  type     = "CNAME"
  value    = "@"
  ttl      = 600
  proxied  = false
}
