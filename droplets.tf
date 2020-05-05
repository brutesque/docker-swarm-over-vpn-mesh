resource "digitalocean_ssh_key" "laptop" {
  name       = "Laptop"
  public_key = file("secrets/ssh/laptop.id_rsa.pub")
}
resource "digitalocean_ssh_key" "workstation" {
  name       = "Workstation"
  public_key = file("secrets/ssh/workstation.id_rsa.pub")
}

# Droplets
resource "digitalocean_droplet" "droplet01" {
    image = "ubuntu-18-04-x64"
    name = "droplet01"
    region = "nyc1"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet02" {
    image = "ubuntu-18-04-x64"
    name = "droplet02"
    region = "sfo2"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet03" {
    image = "ubuntu-18-04-x64"
    name = "droplet03"
    region = "ams3"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet04" {
    image = "ubuntu-18-04-x64"
    name = "droplet04"
    region = "sgp1"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet05" {
    image = "ubuntu-18-04-x64"
    name = "droplet05"
    region = "lon1"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet06" {
    image = "ubuntu-18-04-x64"
    name = "droplet06"
    region = "fra1"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet07" {
    image = "ubuntu-18-04-x64"
    name = "droplet07"
    region = "tor1"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
resource "digitalocean_droplet" "droplet08" {
    image = "ubuntu-18-04-x64"
    name = "droplet08"
    region = "blr1"
    size = "1gb"
    ssh_keys = [digitalocean_ssh_key.laptop.fingerprint, digitalocean_ssh_key.workstation.fingerprint]
}
