variable "do_token" {}
variable "vultr_token" {}

provider "digitalocean" {
  token = var.do_token
  version = "~> 1.19"
}

provider "vultr" {
  api_key = var.vultr_token
  version = "~> 1.3"
}
