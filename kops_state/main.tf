resource "aws_s3_bucket" "kops_state_bucket" {
  bucket        = local.kops_state_name
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
    var.tags,
    local.module_tags,
    map ("infra.name", local.kops_state_name)
  )
}
