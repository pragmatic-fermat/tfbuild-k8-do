terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.71.0"
    }
  }
}

variable "do_token" {}
variable "access_id" {}
variable "secret_key" {}

variable "entropy" {}

variable "nb_clusters" { type = number }
variable "node_count"  { type = number }
variable "droplet_size" { type = string }
variable "k8s_version" { type = string }

provider "digitalocean" {
  token = var.do_token
  spaces_access_id  = var.access_id
  spaces_secret_key = var.secret_key
}
