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

variable "domain_name" {
  default = null
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
  sensitive = true
}

variable "do_instance_count" {
  description = "Digital Ocean API Token"
  default     = 0
}

variable "oci_instance_count" {
  description = "Number of instances on Oracle Cloud Infrastructure"
  default     = 0
}

variable "vultr_instance_count" {
  description = "Number of instances on Vultr"
  default     = 0
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
