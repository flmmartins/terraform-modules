## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| module\_version | module\_version | `string` | `"master"` | no |
| name | Name of hosted zone | `any` | n/a | yes |
| tags | Tags for hosted zone | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| hosted\_zone | Map of hosted zone with zone\_id,name\_servers |

