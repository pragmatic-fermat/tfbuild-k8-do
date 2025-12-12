variable "region_name" {
  type        = string
}

# Ces variables sont maintenant stockées dans un env de Terraform
#variable "droplet_size" {
#  type        = string
#}
#variable "node_count" {
#  type        = number
#}
#variable "k8s_version" {
#  type        = string
#}
#variable "nb_clusters" {
#  type      = number
#}

####
# Attention a l'overlap
resource "digitalocean_vpc" "k8s_vpc" {
  name   = "k8s-vpc-training"
  region = var.region_name
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  count = var.nb_clusters
  name    = "k8-do-grp${count.index}-${var.entropy}"
  region  = var.region_name
  version = var.k8s_version
  destroy_all_associated_resources = true
  vpc_uuid = digitalocean_vpc.k8s_vpc.id
  cluster_subnet = "192.168.16.0/20"
  service_subnet = "192.168.32.0/20"

  # This default node pool is mandatory
  node_pool {
    name       = "node"
    size       = var.droplet_size
    auto_scale = false
    node_count = var.node_count
  }
}

resource "digitalocean_project" "trainingk8" {
  name        = "trainingk8s"
  description = "trainingk8s"
  purpose     = "Web Application"
  environment = "Development"
  resources   = digitalocean_kubernetes_cluster.cluster[*].urn
}

resource "digitalocean_spaces_bucket" "kconfig-l" {
  name   = "kconfig-l"
  region = "fra1"
  force_destroy = true
}
