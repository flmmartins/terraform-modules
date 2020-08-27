## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |
| terraform | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocated\_storage | Storage size | `number` | `10` | no |
| aws\_region | AWS Region | `any` | n/a | yes |
| backup\_retention\_period | Backup retention period in days | `number` | `7` | no |
| backup\_window | Window to do backups in UTC | `string` | `"02:00-05:00"` | no |
| client\_sg\_filter | List of strings which will be used to find security groups names that matches the filter to allow into database | `list` | n/a | yes |
| db\_admin\_username | Admin Username of the database | `string` | `"superadmin"` | no |
| db\_name | Name of the database | `any` | n/a | yes |
| engine | Database engine | `string` | `"postgres"` | no |
| engine\_version | Engine version | `any` | n/a | yes |
| environment | Environment where load balancer will serve | `any` | n/a | yes |
| instance\_class | Instance class | `string` | `"db.t2.micro"` | no |
| is\_multi\_az | Multi AZ option | `bool` | `false` | no |
| maintenance\_window | Maintenance window for changes in UTC | `string` | `"Sun:23:00-Mon:02:00"` | no |
| major\_engine\_version | Major engine version | `any` | n/a | yes |
| module\_version | Module Version | `string` | `"master"` | no |
| subnets\_cidr | Subnets the database will be connected to | `list` | n/a | yes |
| tags | Tags for RDS instance | `map` | n/a | yes |
| terraform\_state | State Name to get variables from | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| admin\_password | n/a |
| db | n/a |

