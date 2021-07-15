variable "prem_instances" {
  description = "On-premise instances"
  sensitive   = false
  default     = {}
}

variable "ssh_public_key_path" {
  sensitive = true
  default   = null
}

variable "duckdns_token" {
  sensitive = true
  default   = null
}

variable "project_name" {
  description = "Name for the swarm project"
  sensitive   = true
  default     = "Playground"
}

variable "admin_password" {
  sensitive = true
}

variable "admin_email" {
  default   = ""
  sensitive = true
}

variable "user_name" {
  sensitive = true
}

variable "user_password" {
  sensitive = true
}

variable "stacks_portainer" {
  default = true
}

variable "stacks_swarmpit" {
  default = false
}

variable "stacks_swarmprom" {
  default = false
}

variable "stacks_tests" {
  default = false
}

variable "duckdns_subdomains" {
  sensitive = false
}

variable "digitalocean_instances" {
  description = "List of sizes and regions for instances on Digital Ocean"
  default = []
}

variable "oraclecloud_instances" {
  description = "List of shapes for instances on Oracle Cloud Infrastructure"
  default = []
}

variable "transip_instances" {
  description = "List of product names for instances on TransIP"
  default = []
}

variable "vultr_instances" {
  description = "List of plans and regions for instances on Vultr"
  default = []
}

variable "do_token" {
  description = "Digital Ocean API Token"
  sensitive   = true
  default     = null
}

variable "oci_api_key_fingerprint" {
  sensitive   = true
  default     = null
}

variable "oci_api_private_key_path" {
  sensitive = true
  default   = null
}

variable "oci_compartment_ocid" {
  sensitive   = true
  default     = null
}

variable "oci_tenancy_ocid" {
  sensitive   = true
  default     = null
}

variable "oci_user_ocid" {
  sensitive   = true
  default = null
}

variable "oci_region" {
  sensitive = true
  default   = null
}

variable "oci_free_tier_availability_domain" {
  sensitive = true
  default   = null
}

variable "vultr_token" {
  description = "Vultr API Token"
  sensitive   = true
  default     = null
}

variable "transip_account_name" {
  description = "Name of the TransIP account"
  sensitive   = true
  default     = null
}

variable "transip_private_key_path" {
  description = "Path to the private key file to be used to authenticate"
  sensitive   = true
  default     = null
}

variable "existing_transip_instances" {
  description = "Names of existing TransIP instances to include"
  sensitive = false
  default = []
}

variable "manager_providers" {
  description = "Prioritized providers to spread out managers"
  sensitive   = false
  default     = []
}

variable "manager_count" {
  type        = number
  description = "Number of managers in the docker swarm"
  sensitive   = false
  default     = 3
}

variable "entrypoint_providers" {
  description = "Prioritized providers to spread out entrypoints"
  sensitive   = false
  default     = []
}

variable "entrypoint_count" {
  type        = number
  description = "Number of entrypoints in the docker swarm"
  sensitive   = false
  default     = 1
}

variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  sensitive   = true
  default     = null
}

variable "services_subdomain" {
  description = "Subdomain for swarm services"
  sensitive   = false
  default     = null
}

variable "manual_domains" {
  description = "Manually configured domains"
  sensitive   = false
  default     = []
}

variable "cloudflare_domains" {
  description = "Cloudflare zones"
  sensitive   = false
  default     = []
}

variable "transip_domains" {
  description = "TransIP domains"
  sensitive   = false
  default     = []
}
