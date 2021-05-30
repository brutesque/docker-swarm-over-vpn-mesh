resource "vultr_ssh_key" "deploy" {
  name    = "Deploy"
  ssh_key = trimspace(file(var.ssh_public_key_path))
}

resource "vultr_instance" "instances" {
  count            = var.instance_count
  label            = format("vultr-instance-%02d", count.index + 1)
  hostname         = format("vultr-instance-%02d", count.index + 1)
  region           = var.vultr_regions[count.index % length(var.vultr_regions)]
  plan             = "vc2-1c-1gb"
  os_id            = 387 # "Ubuntu 20.04 x64"
  backups          = "disabled"
  ddos_protection  = false
  ssh_key_ids      = [
    vultr_ssh_key.deploy.id,
  ]
  activation_email = false
}
