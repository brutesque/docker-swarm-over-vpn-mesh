
variable "vultr_token" {
  description = "Vultr API Token"
  sensitive   = true
}

provider "vultr" {
  api_key = var.vultr_token
  rate_limit = 700
  retry_limit = 3
}

resource "vultr_ssh_key" "deploy" {
  name       = "Deploy"
  ssh_key = trimspace(file(var.ssh_public_key_path))
}

variable "vultr_regions" {
  type = list

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

resource "vultr_instance" "instances" {
  count = var.vultr_instance_count
  label = format("vultr-instance-%02d", count.index + 1)
  hostname = format("vultr-instance-%02d", count.index + 1)
  region = var.vultr_regions[count.index % length(var.vultr_regions)]
  plan = "vc2-1c-1gb"
  os_id = 387 # "Ubuntu 20.04 x64"
  backups = "disabled"
  ddos_protection = false
  ssh_key_ids = [
    vultr_ssh_key.deploy.id,
  ]
  activation_email = false
}
