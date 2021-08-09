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
  domain_names = keys(local.zone_ids)
}

resource "cloudflare_record" "entrypoints" {
  count    = length(local.entrypoints)
  zone_id  = local.entrypoints[count.index][0]
  name     = format("*.%s", var.subdomain)
  type     = "A"
  value    = local.entrypoints[count.index][1]
  ttl      = 300
  proxied  = false
}

resource "cloudflare_record" "leader" {
  count    = length(local.zone_ids)
  zone_id  = values(local.zone_ids)[count.index]
  name     = format("leader.%s", var.subdomain)
  type     = "A"
  value    = var.leader
  ttl      = 300
  proxied  = false
}
