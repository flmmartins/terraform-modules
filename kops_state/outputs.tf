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
