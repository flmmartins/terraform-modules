output "kops_user" {
  description = "Map of Kops user with name,arn and id"
  value = {
    "name" = module.kops_user.this_iam_user_name
    "arn"  = module.kops_user.this_iam_user_arn
    "id"   = module.kops_user.this_iam_user_unique_id
  }
}

output "kops_user_credentials" {
  description = "Map of kops user creds with access_key_id, access_key_secret"
  sensitive = true
  value = {
    "access_key_id"     = module.kops_user.this_iam_access_key_id
    "access_key_secret" = module.kops_user.this_iam_access_key_secret
  }
}

output "kops_group" {
  description = "Name of kops group"
  value       = module.kops_group.this_group_name
}

output "kops_group_users" {
  description = "List of users inside kops group"
  value       = module.kops_group.this_group_users
}

output "kops_state_bucket" {
  description = "Map of Kops state details with id,arn,region,domain_name,regional_domain_name,zone_id"
  value       = {
    "id"                   = aws_s3_bucket.kops_state_bucket.id
    "arn"                  = aws_s3_bucket.kops_state_bucket.arn
    "region"               = aws_s3_bucket.kops_state_bucket.region
    "domain_name"          = aws_s3_bucket.kops_state_bucket.bucket_domain_name
    "regional_domain_name" = aws_s3_bucket.kops_state_bucket.bucket_regional_domain_name
    "zone_id"              = aws_s3_bucket.kops_state_bucket.hosted_zone_id
  }
}
