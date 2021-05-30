variable "instance_count" {
  description = "Number of instances on Vultr"
  default     = 0
}

variable "ssh_public_key_path" {
  description = "Path to public key file"
  sensitive   = true
  default     = null
}

variable "api_key" {
  description = "Vultr API Token"
  sensitive   = true
  default     = null
}

variable "vultr_regions" {
  type    = list
  default = [
    "ams", # Amsterdam
    "lhr", # London
    "fra", # Frankfurt
    "cdg", # Paris
    "nrt", # Tokyo
    "icn", # Seoul
    "sgp", # Singapore
    "yto", # Toronto
    "mia", # Miami
    "sjc", # Silicon Valley
    "ewr", # New Jersey
    "ord", # Chicago
    "dfw", # Dallas
    "sea", # Seattle
    "lax", # Los Angeles
    "atl", # Atlanta
    "syd", # Sydney
  ]
}

