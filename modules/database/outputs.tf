output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = alicloud_db_instance.mysql.id
}

output "db_instance_name" {
  description = "The name of the RDS instance"
  value       = alicloud_db_instance.mysql.instance_name
}

output "db_instance_type" {
  description = "The type of the RDS instance"
  value       = alicloud_db_instance.mysql.instance_type
}

output "db_instance_storage" {
  description = "The storage size of the RDS instance"
  value       = alicloud_db_instance.mysql.instance_storage
}

output "db_instance_engine" {
  description = "The engine of the RDS instance"
  value       = alicloud_db_instance.mysql.engine
}

output "db_instance_engine_version" {
  description = "The engine version of the RDS instance"
  value       = alicloud_db_instance.mysql.engine_version
}

output "db_instance_connection_string" {
  description = "The connection string of the RDS instance"
  value       = alicloud_db_instance.mysql.connection_string
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = alicloud_db_instance.mysql.port
}

output "db_instance_status" {
  description = "The status of the RDS instance"
  value       = alicloud_db_instance.mysql.status
} 