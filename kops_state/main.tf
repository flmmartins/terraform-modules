module "kops_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 2.0"

  name = "kops"
  path = "services/"

    # This allow terraform to destroy user even if user was changed manually
  force_destroy                 = true
  create_iam_user_login_profile = false
  create_iam_access_key         = true
}

module "iam_group_with_policies" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version = "~> 2.0"

  name = "kops"

  group_users = [
    module.kops_user.this_iam_user_name
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  ]
}

resource "aws_s3_bucket" "kops_state_bucket" {
  bucket        = var.s3_state_name
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days = 10
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }

  tags = merge(
    var.env_tags,
    local.module_tags
    map ("infra.name", local.s3_state_name)
  )
}
