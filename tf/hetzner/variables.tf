variable "ssh_public_key_path" {
  description = "Path to public key file"
  sensitive   = true
  default     = null
}

variable "api_key" {
  description = "Hetzner Cloud API Key"
  sensitive   = true
  default     = null
}

variable "hetzner_regions" {
  type    = list
  default = [
    "nbg1", # Nuremberg
    "fsn1", # Falkenstein
    "hel1", # Helsinki
  ]
}

variable "project_name" {
  description = "Name for the swarm project"
  sensitive = true
  default = "Playground"
}

variable "instances" {
  description = "List of server types and regions for instances on Hetnzer Cloud"
  default = []
}
