variable "module_version" {
  description = "Module Version"
  default     = "master"
}

variable "tags" {
  description = "Network Tags"
  type        = map
  default     = {}
}

variable "vpc_name" {
  description = "Name of VPC"
}

variable "vpc_cidr" {
  description = "CIDR of VPC"
}

variable "vpc_public_subnets_cidr" {
  description = "CIDR of public subnet of vpc"
  type        = list
}

variable "vpc_private_subnets_cidr" {
  description = "CIDR of private subnet of vpc"
  type        = list
}

locals {
  module_tags = {
    "terraform.module"         = "network"
    "terraform.module.version" = var.module_version
  }
}
