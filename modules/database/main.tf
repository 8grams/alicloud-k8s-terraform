# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
resource "alicloud_db_instance" "mysql" {
  engine               = "MySQL"
  engine_version       = var.engine_version
  instance_type        = var.instance_type
  instance_storage     = var.instance_storage
  instance_charge_type = var.instance_charge_type
  instance_name        = "${var.name_prefix}-mysql"
  vswitch_id           = var.vswitch_ids[0]
  security_ips         = var.security_ips

  zone_id = var.vswitch_ids[0]

  tags = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_backup_policy
resource "alicloud_db_backup_policy" "mysql_backup" {
  instance_id = alicloud_db_instance.mysql.id

  backup_retention_period = var.backup_retention_period
  preferred_backup_time   = var.backup_time
  preferred_backup_period = var.backup_period
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance_parameter
resource "alicloud_db_instance_parameter" "mysql_params" {
  instance_id = alicloud_db_instance.mysql.id
  
  parameter {
    name  = "innodb_buffer_pool_size"
    value = "1073741824"
  }
  
  parameter {
    name  = "max_connections"
    value = "1000"
  }
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/rds_account
resource "alicloud_rds_account" "mysql_account" {
  db_instance_id  = alicloud_db_instance.mysql.id
  account_name         = var.db_username
  account_password     = var.db_password
  account_type         = "Super"
} 