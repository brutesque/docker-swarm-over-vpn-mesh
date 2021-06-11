variable "instance_count" {
  description = "Number of instances on Transip"
  default     = 0
}

variable "ssh_public_key_path" {
  description = "Path to public key file"
  sensitive   = true
  default     = null
}

variable "account_name" {
  description = "Name of the Transip account"
  sensitive   = true
  default     = null
}

variable "private_key" {
  description = "Contents of the private key file to be used to authenticate"
  sensitive   = true
  default     = null
}

variable "instance_names" {
  description = "Names of existing Transip instances to include"
  sensitive   = false
  default     = []
}

variable "project_name" {
  description = "Name for the swarm project"
  sensitive = true
  default = "Playground"
}
