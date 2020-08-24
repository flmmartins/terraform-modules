variable "env_tags" {
  description = "Environment tags"
  type        = map
  default     = {}
}

variable "aws_account_name" {
  description = "Account name to add to the kops state"
}

variable "aws_region" {
  description = "Ragion name to add to the kops state"
}

variable "kops_state_prefix" {
  description = "Prefix name for kops state"
  default     = "kops-state-store"
}

variable "module_version" {
  description = "Module version"
}

locals {
  module_tags = {
    "infra.component"          = "kops_state"
    "terraform.module"         = "kops_state"
    "terraform.module_version" = var.module_version
  }
  kops_state_name = "${var.kops_state_prefix}-${var.aws_account_name}-${var.aws_region}"
}
