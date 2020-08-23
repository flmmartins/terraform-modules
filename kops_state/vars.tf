variable "env_tags" {
  description = "Environment tags"
  type        = map
  default     = {}
}

variable "s3_state_name" {
  description = "Name of s3 bucket with state"
  default     = "kops-state-store"
}

variable "module_version" {
  description = "Module version"
}

locals {
  module_tags {
    "infra.component"          = "kops_state"
    "terraform.module"         = "kops_state"
    "terraform.module_version" = var.module_version
  }
}
