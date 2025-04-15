output "key_name" {
  description = "The name of the key pair"
  value       = alicloud_ecs_key_pair.key.key_pair_name
}

output "fingerprint" {
  description = "The fingerprint of the key pair"
  value       = alicloud_ecs_key_pair.key.finger_print
}

output "private_key_path" {
  description = "Path to the generated private key file"
  value       = local_sensitive_file.private_key.filename
}

output "public_key_path" {
  description = "Path to the generated public key file"
  value       = local_file.public_key.filename
}