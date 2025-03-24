variable "access_key" {
  description = "Alibaba Cloud access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Alibaba Cloud secret key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "Alibaba Cloud region"
  type        = string
  default     = "ap-southeast-5"
}

variable "name_prefix" {
  description = "Prefix to be used on all resources"
  type        = string
  default     = "pintar"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "nat_bandwidth" {
  description = "Bandwidth for NAT Gateway EIP"
  type        = number
  default     = 10
}

variable "db_instance_type" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "mysql.n2.small.2c"
}

variable "db_instance_storage" {
  description = "The storage size in GB of the RDS instance"
  type        = number
  default     = 20
}

variable "db_account_name" {
  description = "The name of the database account"
  type        = string
  default     = "admin"
}

variable "db_account_password" {
  description = "The password of the database account"
  type        = string
  sensitive   = true
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.26.3"
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

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Terraform   = "true"
  }
} 