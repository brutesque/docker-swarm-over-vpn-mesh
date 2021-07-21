variable "account_name" {
  description = "Name of the TransIP account"
  sensitive   = true
  default     = null
}

variable "private_key" {
  description = "Contents of the private key file to be used to authenticate"
  sensitive   = true
  default     = null
}

variable "domain_names" {
  description = "Domain names hosted at TransIP"
  sensitive   = false
  default     = ""
}

variable "entrypoints" {
  description = "Entrypoint IP's to point A records to"
  sensitive   = false
  default     = {}
}

variable "subdomain" {
  description = "Subdomain to create for swarm services"
  sensitive   = false
  default     = []
}

variable "leader" {
  description = "First manager in the swarm"
  sensitive   = false
  default     = null
}
