variable "do_instance_count" {
  description = "Number of instances on Digital Ocean"
}
variable "oci_instance_count" {
  description = "Number of instances on Oracle Cloud Infrastructure"
}
variable "vultr_instance_count" {
  description = "Number of instances on Vultr"
}

variable "ssh_public_key_path" {
  sensitive = true
}
variable "duckdns_token" {
  sensitive = true
}
variable "domain_name" {}
variable "admin_password" {
  sensitive = true
}
variable "admin_email" {
  default = ""
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
