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

output "node_pool_id" {
  description = "The ID of the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.id
}

output "node_pool_name" {
  description = "The name of the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.name
}

output "node_pool_instance_ids" {
  description = "List of instance IDs in the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.instance_ids
}

output "node_pool_nodes" {
  description = "List of nodes in the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.nodes
} 