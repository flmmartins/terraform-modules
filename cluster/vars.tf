variable "module_version" {
  description = "Module version"
  default     = "master"
}

variable "environment" {
  description = "Environment name"
}

variable "aws_region" {
  description = "AWS Region"
}

variable "terraform_state" {
  description = "State Name to get variables from"
}

variable "kubernetes_version" {
  description = "Kubernetes version"
}

variable "cluster_api_allowed_ip" {
  type = list
  default = ["213.127.30.50/32"]
  description = "Ip address allowed to access KOPS API."
}

variable "cluster_ssh_allowed_ip" {
  type = list
  default = ["213.127.30.50/32"]
  description = "Ip address allowed to SSH into kops."
}

variable "cluster_name" {
  description = "Cluster full name in following format: mycluster.something.com"
}

variable "kubernetes_cidr" {
  description = "CIDR of Kubernetes"
  default     = "100.64.0.0/10"
}

variable "private_subnet_cidr" {
  description = "Cluster private subnet cidr"
}

variable "public_subnet_cidr" {
  description = "Cluster public subnet aka utility in Kops"
}

variable "dns_type" {
  description = "DNS Type: Public Or Private"
  default     = "Private"
}

variable "nodes" {
  type        = map
  description = "Nodes details as map. It's required min_count, max_count, instance_type, image"
}

variable "masters" {
  type        = map
  description = "Masters details as map. It's required min_count, max_count, instance_type, image"
}

variable "pub_admin_key_path" {
  description = "Admin SSH key from cluster"
}


