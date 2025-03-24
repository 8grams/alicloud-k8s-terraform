output "db_instance_id" {
  description = "The ID of the RDS instance"
  value       = alicloud_db_instance.mysql.id
}

output "db_connection_string" {
  description = "The connection string of the database"
  value       = alicloud_db_instance.mysql.connection_string
  sensitive   = true
}

output "db_port" {
  description = "The port of the database"
  value       = alicloud_db_instance.mysql.port
}

output "oss_bucket_id" {
  description = "The ID of the OSS bucket"
  value       = alicloud_oss_bucket.private_bucket.id
}

output "oss_bucket_endpoint" {
  description = "The endpoint of the OSS bucket"
  value       = alicloud_oss_bucket.private_bucket.extranet_endpoint
} 