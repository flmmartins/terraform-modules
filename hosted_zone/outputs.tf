output "hosted_zone" {
  description = "Map of hosted zone with zone_id,name_servers"
  value = {
    "name"         = var.name
    "zone_id"      = aws_route53_zone.hosted_zone.zone_id
    "name_servers" = aws_route53_zone.hosted_zone.name_servers
  }
}
