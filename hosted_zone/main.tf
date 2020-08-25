resource "aws_route53_zone" "hosted_zone" {
  name         = var.name
  tags = merge(
    var.tags,
    local.module_tags,
    map (
      "Name", var.name,
      "infra.name", var.name
    )
  )
}
