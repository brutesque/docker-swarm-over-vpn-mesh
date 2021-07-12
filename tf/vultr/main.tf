resource "vultr_ssh_key" "deploy" {
  name    = format("Deploy: %s", var.project_name)
  ssh_key = trimspace(file(var.ssh_public_key_path))
}

resource "vultr_instance" "instances" {
  count            = length(var.instances)
  label            = format("vultr-instance-%02d", count.index + 1)
  hostname         = format("vultr-instance-%02d", count.index + 1)
  region           = element(var.instances, count.index)[1]
  plan             = element(var.instances, count.index)[0]
  os_id            = 387 # "Ubuntu 20.04 x64"
  backups          = "disabled"
  ddos_protection  = false
  ssh_key_ids      = [
    vultr_ssh_key.deploy.id,
  ]
  activation_email = false
}
