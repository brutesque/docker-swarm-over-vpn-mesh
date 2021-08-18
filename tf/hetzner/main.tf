resource "hcloud_ssh_key" "deploy" {
  name       = format("Deploy: %s", var.project_name)
  public_key = trimspace(file(var.ssh_public_key_path))
}

resource "hcloud_server" "instances" {
  count              = length(var.instances)
  image              = "ubuntu-20.04"
  name               = format("hetzner-instance-%02d", count.index + 1)
  location           = element(var.instances, count.index)[1]
  server_type        = element(var.instances, count.index)[0]
  ssh_keys           = [
    hcloud_ssh_key.deploy.id,
  ]
}
