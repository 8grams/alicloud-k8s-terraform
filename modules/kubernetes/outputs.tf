output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.id
}

output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.connections.api_server_internet
}

output "kubeconfig_file" {
  description = "The kubeconfig file for the cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.kube_config
  sensitive   = true
} 