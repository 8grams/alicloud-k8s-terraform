output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "private_vswitch_ids" {
  description = "List of private vswitch IDs"
  value       = module.vpc.private_vswitch_ids
}

output "public_vswitch_ids" {
  description = "List of public vswitch IDs"
  value       = module.vpc.public_vswitch_ids
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.security.security_group_id
}

output "k8s_access_key_id" {
  description = "The access key ID for Kubernetes"
  value       = module.security.k8s_access_key_id
  sensitive   = true
}

output "k8s_access_key_secret" {
  description = "The access key secret for Kubernetes"
  value       = module.security.k8s_access_key_secret
  sensitive   = true
}

output "db_connection_string" {
  description = "The connection string of the database"
  value       = module.database.db_connection_string
  sensitive   = true
}

output "db_port" {
  description = "The port of the database"
  value       = module.database.db_port
}

output "oss_bucket_endpoint" {
  description = "The endpoint of the OSS bucket"
  value       = module.database.oss_bucket_endpoint
}

output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = module.kubernetes.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = module.kubernetes.cluster_endpoint
}

output "kubeconfig_file" {
  description = "The kubeconfig file for the cluster"
  value       = module.kubernetes.kubeconfig_file
  sensitive   = true
} 