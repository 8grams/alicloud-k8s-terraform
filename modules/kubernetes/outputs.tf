output "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.id
}

output "cluster_name" {
  description = "Name of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.name
}

output "cluster_endpoint" {
  description = "The endpoint of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.connections.api_server_internet
}

output "cluster_cert" {
  description = "The certificate authority of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.certificate_authority["cluster_cert"]
}

output "client_cert" {
  description = "The client certificate of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.certificate_authority["client_cert"]
}

output "client_key" {
  description = "The client key of the Kubernetes cluster"
  value       = alicloud_cs_managed_kubernetes.cluster.certificate_authority["client_key"]
}

output "node_pool_id" {
  description = "The ID of the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.id
}

output "node_pool_name" {
  description = "The name of the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.node_pool_name
}

output "node_pool_instance_ids" {
  description = "List of instance IDs in the node pool"
  value       = alicloud_cs_kubernetes_node_pool.default.instances
}
