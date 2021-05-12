terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.8.0"
    }

    vultr = {
      source  = "vultr/vultr"
      version = "2.1.4"
    }
  }

  required_version = "~> 0.14.9"
}
