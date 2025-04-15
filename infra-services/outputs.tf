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

output "kubernetes_security_group_id" {
  description = "The ID of the security group"
  value       = module.kubernetes_security_group.security_group_id
}

output "k8s_access_key_id" {
  description = "The access key ID for Kubernetes"
  value       = module.ram.k8s_access_key_id
  sensitive   = true
}

output "k8s_access_key_secret" {
  description = "The access key secret for Kubernetes"
  value       = module.ram.k8s_access_key_secret
  sensitive   = true
}

output "db_connection_string" {
  description = "The connection string of the database"
  value       = module.database.db_instance_connection_string
  sensitive   = true
}

output "db_port" {
  description = "The port of the database"
  value       = module.database.db_instance_port
}

output "oss_bucket_production_endpoint" {
  description = "The endpoint of the OSS bucket"
  value       = module.storage_production.bucket_endpoint
}

output "oss_bucket_staging_endpoint" {
  description = "The endpoint of the OSS bucket"
  value       = module.storage_staging.bucket_endpoint
}

output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = module.kubernetes.cluster_id
}

output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = module.kubernetes.cluster_endpoint
}

output "cluster_name" {
  description = "The name of the Kubernetes cluster"
  value       = module.kubernetes.cluster_name
}

output "kubeconfig_content" {
  description = "The kubeconfig content for accessing the ACK cluster"
  value       = local_sensitive_file.kubeconfig.content
  sensitive   = true
}

output "node_pool_id" {
  description = "The ID of the node pool"
  value       = module.kubernetes.node_pool_id
}

output "node_pool_name" {
  description = "The name of the node pool"
  value       = module.kubernetes.node_pool_name
}

output "node_pool_instance_ids" {
  description = "List of instance IDs in the node pool"
  value       = module.kubernetes.node_pool_instance_ids
} 