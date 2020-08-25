output "vpc" {
  description = "Map of VPC outputs with arn, id"
  value = {
    "id"   = module.vpc.vpc_id
    "arn"  = module.vpc.vpc_arn
    "cidr" = var.vpc_cidr
  }
}
