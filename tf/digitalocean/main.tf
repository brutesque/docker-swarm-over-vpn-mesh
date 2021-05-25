resource "digitalocean_ssh_key" "deploy" {
  name       = "Deploy"
  public_key = trimspace(file(var.ssh_public_key_path))
}

# Droplets
resource "digitalocean_droplet" "instances" {
  count = var.instance_count
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