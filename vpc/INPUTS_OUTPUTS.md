## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| module\_version | Module Version | `string` | `"master"` | no |
| tags | Network Tags | `map` | `{}` | no |
| vpc\_cidr | CIDR of VPC | `any` | n/a | yes |
| vpc\_name | Name of VPC | `any` | n/a | yes |
| vpc\_private\_subnets\_cidr | CIDR of private subnet of vpc | `list` | n/a | yes |
| vpc\_public\_subnets\_cidr | CIDR of public subnet of vpc | `list` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc | Map of VPC outputs with arn, id |

