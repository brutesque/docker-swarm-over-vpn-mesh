variable "instance_count" {
  description = "Number of instances on Digital Ocean"
  default = 0
}

variable "ssh_public_key_path" {
  description = "Path to public key file"
  sensitive = true
  default = null
}

variable "api_key" {
  description = "Digital Ocean API Key"
  sensitive = true
  default = null
}

variable "digitalocean_regions" {
  type = list

  default = [
    "ams3", # Amsterdam
    "lon1", # London
    "fra1", # Frankfurt
    "sgp1", # Singapore
    "tor1", # Toronto
    "sfo3", # San Fransisco
    "nyc1", # New York
    "blr1", # Bangalore
  ]
}

