variable "api_token" {
  description = "Cloudflare API Token"
  sensitive   = true
  default     = null
}

variable "domain_names" {
  description = "Cloudflare Zones"
  sensitive   = false
  default     = []
}

variable "entrypoints" {
  description = "Entrypoint IP's to point A records to"
  sensitive   = false
  default     = []
}

variable "subdomain" {
  description = "Subdomain to create for swarm services"
  sensitive   = false
  default     = []
}
