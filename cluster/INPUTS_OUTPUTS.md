## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| null | n/a |
| template | n/a |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | AWS Region | `any` | n/a | yes |
| cluster\_api\_allowed\_ip | Ip address allowed to access KOPS API. | `list` | n/a | yes |
| cluster\_name | Cluster full name in following format: mycluster.something.com | `any` | n/a | yes |
| cluster\_ssh\_allowed\_ip | Ip address allowed to SSH into kops. | `list` | n/a | yes |
| dns\_type | DNS Type: Public Or Private | `string` | `"Private"` | no |
| environment | Environment name | `any` | n/a | yes |
| kubernetes\_cidr | CIDR of Kubernetes | `string` | `"100.64.0.0/10"` | no |
| kubernetes\_version | Kubernetes version | `any` | n/a | yes |
| masters | Masters details as map. It's required min\_count, max\_count, instance\_type, image | `map` | n/a | yes |
| module\_version | Module version | `string` | `"master"` | no |
| nodes | Nodes details as map. It's required min\_count, max\_count, instance\_type, image | `map` | n/a | yes |
| private\_subnet\_cidr | Cluster private subnet cidr | `any` | n/a | yes |
| pub\_admin\_key\_path | Admin SSH key from cluster | `any` | n/a | yes |
| public\_subnet\_cidr | Cluster public subnet aka utility in Kops | `any` | n/a | yes |
| terraform\_state | State Name to get variables from | `any` | n/a | yes |

## Outputs

No output.

