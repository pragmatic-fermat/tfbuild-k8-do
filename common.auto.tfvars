# Region where resources should be created
region_name = "fra1"
# Droplet size
droplet_size = "s-2vcpu-4gb"

# Nb Nodes dans chaque cluster
node_count="3"

# Grab the latest version slug from 
## `doctl kubernetes options versions`
k8s_version="1.30.10-do.0"

##
## Maintenant utilisée en env Terraform
## nb_clusters=3
