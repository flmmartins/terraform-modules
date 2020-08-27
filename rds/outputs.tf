output "db" {
  value                         = {
    db_name                     = module.db.this_db_instance_name
    hostname                    = module.db.this_db_instance_address
    port                        = module.db.this_db_instance_port
    admin_username              = module.db.this_db_instance_username
    db_instance_identifier_name = local.db_name_long
  }
}

output "admin_password" {
  sensitive = true
  value     = module.db.this_db_instance_password
}
