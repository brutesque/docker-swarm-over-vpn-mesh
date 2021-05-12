variable "do_token" {
  description = "Digital Ocean API Token"
  sensitive   = true
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "deploy" {
  name       = "Deploy"
  public_key = trimspace(file(var.ssh_public_key_path))
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

# Droplets
resource "digitalocean_droplet" "instances" {
  count = var.do_instance_count
  image = "ubuntu-20-04-x64"
  name = format("do-instance-%02d", count.index + 1)
  region = var.digitalocean_regions[count.index % length(var.digitalocean_regions)]
  size = "s-1vcpu-1gb"
  monitoring = false
  private_networking = false
  ssh_keys = [
    digitalocean_ssh_key.deploy.fingerprint,
  ]
}

resource "digitalocean_project" "playground" {
  name        = "playground"
  environment = "Development"
  resources   = digitalocean_droplet.instances.*.urn
}
