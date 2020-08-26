## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_account\_name | Account name to add to the kops state | `any` | n/a | yes |
| aws\_region | Region name to add to the kops state | `any` | n/a | yes |
| kops\_state\_prefix | Prefix name for kops state | `string` | `"kops-state-store"` | no |
| module\_version | Module version | `string` | `"master"` | no |
| tags | Environment tags | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| kops\_state\_bucket | Map of Kops state details with id,arn,region,domain\_name,regional\_domain\_name,zone\_id |

