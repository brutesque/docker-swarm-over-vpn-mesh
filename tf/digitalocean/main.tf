resource "digitalocean_ssh_key" "deploy" {
  name       = format("Deploy: %s", var.project_name)
  public_key = trimspace(file(var.ssh_public_key_path))
}

resource "digitalocean_droplet" "instances" {
  count              = length(var.instances)
  image              = "ubuntu-20-04-x64"
  name               = format("do-instance-%02d", count.index + 1)
  region             = element(var.instances, count.index)[1]
  size               = element(var.instances, count.index)[0]
  monitoring         = false
  private_networking = false
  ssh_keys           = [
    digitalocean_ssh_key.deploy.fingerprint,
  ]
}

resource "digitalocean_project" "playground" {
  name        = var.project_name
  resources   = digitalocean_droplet.instances.*.urn
}
