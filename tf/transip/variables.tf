variable "ssh_public_key_path" {
  description = "Path to public key file"
  sensitive   = true
  default     = null
}

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

variable "existing_instances" {
  description = "Names of existing TransIP instances to include"
  sensitive   = false
  default     = []
}

variable "project_name" {
  description = "Name for the swarm project"
  sensitive   = true
  default     = "Playground"
}

variable "instances" {
  description = "List of product names for instances on TransIP"
  default = []
}
