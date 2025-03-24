variable "name_prefix" {
  description = "Prefix to be used on all resources"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.26.3"
}

variable "vswitch_ids" {
  description = "List of vswitch IDs for worker nodes"
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Terraform   = "true"
  }
} 