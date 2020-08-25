variable "module_version" {
  description = "module_version"
  default = "master"
}

variable "tags" {
  description = "Tags for hosted zone"
  type        = map
  default     = {}
}

variable "name" {
  description = "Name of hosted zone"
}

locals {
  module_tags = {
    "terraform.module"         = "hosted_zone"
    "terraform.module.version" = var.module_version
  }
}
