variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
  default     = "k8s"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.26.3"
}

variable "vswitch_ids" {
  description = "List of vswitch IDs for the node pool"
  type        = list(string)
}

variable "pod_vswitch_ids" {
  description = "List of vswitch IDs for pods"
  type        = list(string)
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

variable "worker_nodes_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 2
}

variable "pod_cidr" {
  description = "CIDR block for Kubernetes pods"
  type        = string
  default     = "172.16.0.0/16"
}

variable "service_cidr" {
  description = "CIDR block for Kubernetes services"
  type        = string
  default     = "172.19.0.0/20"
}

variable "worker_disk_size" {
  description = "Size of the worker node disk"
  type        = number
  default     = 40
}

variable "worker_disk_category" {
  description = "Category of the worker node disk"
  type        = string
  default     = "cloud_essd"
}

variable "cluster_id" {
  description = "The ID of the Kubernetes cluster"
  type        = string
}

variable "instance_types" {
  description = "List of instance types for the node pool"
  type        = list(string)
  default     = ["ecs.g6.xlarge"]
}

variable "desired_size" {
  description = "Desired number of nodes in the node pool"
  type        = number
  default     = 2
}

variable "system_disk_category" {
  description = "System disk category for the nodes"
  type        = string
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "System disk size in GB for the nodes"
  type        = number
  default     = 40
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

variable "password" {
  description = "Password for the nodes"
  type        = string
  default     = ""
  sensitive   = true
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

variable "is_bond_eip" {
  description = "Whether to bind EIP to the nodes"
  type        = bool
  default     = false
}

variable "eip_internet_charge_type" {
  description = "Internet charge type for EIP"
  type        = string
  default     = "PayByBandwidth"
}

variable "eip_bandwidth" {
  description = "Bandwidth for EIP"
  type        = number
  default     = 5
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

variable "ingress_nginx_version" {
  description = "Version of ingress-nginx addon"
  type        = string
  default     = "v1.8.0"
}

variable "csi_version" {
  description = "Version of CSI addon"
  type        = string
  default     = "v1.24.6"  # Should match k8s version
}

variable "metrics_server_version" {
  description = "Version of metrics-server addon"
  type        = string
  default     = "v0.6.4"
} 