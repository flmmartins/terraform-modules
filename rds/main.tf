data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = var.terraform_state
    key = "${var.environment}/vpc/terraform.tfstate"
    region = var.aws_region
  }
}

data "aws_subnet_ids" "subnet_ids" {
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc["id"]
  filter {
    name   = "cidr-block"
    values = var.subnets_cidr
  }
}

data "aws_security_groups" "client_sgs" {
  filter {
    name   = "group-name"
    values = var.client_sg_filter
  }
}

resource aws_security_group "rds_security_group" {
  name = "${local.db_name_long}.rds_security_group"
  description = "Sg for database instance. Created by Terraform"

  vpc_id = data.terraform_remote_state.vpc.outputs.vpc["id"]

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = data.aws_security_groups.client_sgs.ids
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource random_string "password"  {
  length = 64
  special = false
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = replace(local.raw_identifier, "/[^a-z0-9-]/", "-")

  name              = var.db_name
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  # Only not encrypted because free tier does not allow it
  storage_encrypted = false


  username = var.db_admin_username

  password = random_string.password.result
  port     = "5432"

  vpc_security_group_ids = [aws_security_group.rds_security_group.id]

  maintenance_window = var.maintenance_window
  backup_window      = var.backup_window

  backup_retention_period = var.backup_retention_period

  tags = merge(
    var.tags,
    local.module_tags,
    map (
      "infra.name", "${local.db_name_long}"
    )
  )

  # DB subnet group
  subnet_ids = data.aws_subnet_ids.subnet_ids.ids

  # DB option group
  family = "postgres${var.major_engine_version}"
  major_engine_version = var.major_engine_version

  # Snatepshot name upon DB deletion
  final_snapshot_identifier = replace(var.db_name, "/[^a-z0-9-]/", "-")

  # Database Deletion Protection
  deletion_protection = true

  multi_az = var.is_multi_az
}
