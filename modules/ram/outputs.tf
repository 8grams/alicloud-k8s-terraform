output "k8s_user_id" {
  description = "The ID of the RAM user"
  value       = alicloud_ram_user.k8s_user.id
}

output "k8s_access_key_id" {
  description = "The access key ID"
  value       = alicloud_ram_access_key.k8s_key.id
  sensitive   = true
}

output "k8s_access_key_secret" {
  description = "The access key secret"
  value       = alicloud_ram_access_key.k8s_key.secret
  sensitive   = true
} 