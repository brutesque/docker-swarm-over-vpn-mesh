variable "do_token" {}
variable "vultr_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "vultr" {
  api_key = var.vultr_token
}
