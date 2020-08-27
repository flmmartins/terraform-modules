variable "aws_region" {
  description = "AWS Region"
}

variable "terraform_state" {
  description = "State Name to get variables from"
}

variable "tags" {
  type        = map
  description = "Tags for RDS instance"
}

variable "db_name" {
  description = "Name of the database"
}

variable "db_admin_username" {
  description = "Admin Username of the database"
  default     = "superadmin"
}

variable "engine" {
  description = "Database engine"
  default = "postgres"
}

variable "subnets_cidr" {
  type        = list
  description = "Subnets the database will be connected to"
}

variable "environment" {
  description = "Environment where load balancer will serve"
}

variable "client_sg_filter" {
  type        = list
  description = "List of strings which will be used to find security groups names that matches the filter to allow into database"
}

variable "instance_class" {
  default     = "db.t2.micro"
  description = "Instance class"
}

variable "allocated_storage" {
  default     = 10
  description = "Storage size"
}

variable "is_multi_az" {
  default     = false
  description = "Multi AZ option"
}

variable "major_engine_version" {
  description = "Major engine version"
}

variable "engine_version" {
  description = "Engine version"
}

variable "backup_retention_period" {
  default     = 7
  description = "Backup retention period in days"
}

variable "maintenance_window" {
  default     = "Sun:23:00-Mon:02:00"
  description = "Maintenance window for changes in UTC"
}

variable "backup_window" {
  default     = "02:00-05:00"
  description = "Window to do backups in UTC"
}

variable "module_version" {
  description = "Module Version"
  default     = "master"
}

locals {
  db_name_long     = "${var.db_name}-${var.environment}"
  raw_identifier   = "${var.db_name}-${var.environment}-db"
  module_tags      = {
    "terraform.module"         = "database"
    "terraform.module.version" = var.module_version
  }
}
