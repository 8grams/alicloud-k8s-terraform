variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
  default     = "k8s"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32.1-aliyun.1"
}

variable "vswitch_ids" {
  description = "List of vswitch IDs for the node pool"
  type        = list(string)
} 

variable "pod_vswitch_ids" {
  description = "List of pod vswitch IDs"
  type        = list(string)
}

variable "service_cidr" {
  description = "CIDR block for Kubernetes services"
  type        = string
  default     = "172.19.0.0/20"
}

variable "security_group_id" {
  description = "ID of the security group"
  type        = string
}

variable "worker_instance_type" {
  description = "Instance type for worker nodes"
  type        = string
  default     = "ecs.c6.large"
}

variable "worker_disk_size" {
  description = "Size of the worker node disk"
  type        = number
  default     = 120
}

variable "worker_disk_category" {
  description = "Category of the worker node disk"
  type        = string
  default     = "cloud_essd"
}

variable "instance_types" {
  description = "List of instance types for the node pool"
  type        = list(string)
  default     = ["ecs.c6.large"]
}

variable "system_disk_category" {
  description = "System disk category for the nodes"
  type        = string
  default     = "cloud_essd"
}

variable "system_disk_size" {
  description = "System disk size in GB for the nodes"
  type        = number
  default     = 120
}

variable "key_name" {
  description = "SSH key name for the nodes"
  type        = string
  default     = ""
}

variable "image_id" {
  description = "Image ID for the nodes"
  type        = string
  default     = ""
}

variable "install_cloud_monitor" {
  description = "Whether to install cloud monitor"
  type        = bool
  default     = true
}

variable "min_size" {
  description = "Minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of nodes in the node pool"
  type        = number
  default     = 10
}

variable "auto_repair" {
  description = "Whether to enable auto repair"
  type        = bool
  default     = true
}

variable "auto_upgrade" {
  description = "Whether to enable auto upgrade"
  type        = bool
  default     = true
}

variable "surge" {
  description = "Number of extra nodes for surge"
  type        = number
  default     = 1
}

variable "max_unavailable" {
  description = "Maximum number of unavailable nodes during upgrade"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "disable_cloud_monitor" {
  description = "Whether to disable cloud-monitor addon"
  type        = bool
  default     = false
}

variable "disable_csi_plugin" {
  description = "Whether to disable csi-plugin addon"
  type        = bool
  default     = false
}

variable "disable_ingress_nginx" {
  description = "Whether to disable nginx-ingress-controller addon"
  type        = bool
  default     = false
}

variable "disable_logtail_ds" {
  description = "Whether to disable logtail-ds addon"
  type        = bool
  default     = false
}

variable "disable_metrics_server" {
  description = "Whether to disable metrics-server addon"
  type        = bool
  default     = false
}

variable "disable_arms_prometheus" {
  description = "Whether to disable arms-prometheus addon"
  type        = bool
  default     = false
}

variable "disable_csi_provisioner" {
  description = "Whether to disable csi-provisioner addon"
  type        = bool
  default     = false
}

variable "disable_terway_eniip" {
  description = "Whether to disable terway-eniip addon"
  type        = bool
  default     = false
}

variable "cool_down_duration" {
  description = "Cool down duration for cluster auto scaling"
  type        = string
  default     = "10m"
}

variable "unneeded_duration" {
  description = "Unneeded duration for cluster auto scaling"
  type        = string
  default     = "10m"
}

variable "utilization_threshold" {
  description = "Utilization threshold for cluster auto scaling"
  type        = number
  default     = 0.7
}

variable "scan_interval" {
  description = "Scan interval for cluster auto scaling"
  type        = string
  default     = "30s"
}

variable "scale_down_enabled" {
  description = "Whether to enable scale down for cluster auto scaling"
  type        = bool
  default     = true
}

variable "expander" {
  description = "Expander for cluster auto scaling"
  type        = string
  default     = "least-waste"
}

variable "skip_nodes_with_system_pods" {
  description = "Whether to skip nodes with system pods"
  type        = bool
  default     = true
}

variable "skip_nodes_with_local_storage" {
  description = "Whether to skip nodes with local storage"
  type        = bool
  default     = false
}

variable "daemonset_eviction_for_nodes" {
  description = "Whether to evict daemonset pods when nodes are deleted"
  type        = bool
  default     = false
}

variable "max_graceful_termination_sec" {
  description = "Maximum graceful termination time for nodes"
  type        = number
  default     = 14400
}

variable "min_replica_count" {
  description = "Minimum number of replicas for cluster auto scaling"
  type        = number
  default     = 0
}

variable "recycle_node_deletion_enabled" {
  description = "Whether to enable recycle node deletion for cluster auto scaling"
  type        = bool
  default     = false
}

variable "scale_up_from_zero" {
  description = "Whether to scale up from zero for cluster auto scaling"
  type        = bool
  default     = true
}

variable "scaler_type" {
  description = "Type of scaler for cluster auto scaling"
  type        = string
  default     = "goatscaler"
}

variable "create_autoscaler_policy" {
  description = "Whether to create the autoscaler policy attachment"
  type        = bool
  default     = true
}