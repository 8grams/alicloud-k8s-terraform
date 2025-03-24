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
  description = "Prefix to be used for resource names"
  type        = string
  default     = "k8s"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "nat_bandwidth" {
  description = "Bandwidth for NAT Gateway"
  type        = number
  default     = 5
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "db_engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "db_instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "mysql.n2.small.2c"
}

variable "db_instance_storage" {
  description = "RDS instance storage in GB"
  type        = number
  default     = 20
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "db_backup_time" {
  description = "Backup time in UTC"
  type        = string
  default     = "02:00Z-03:00Z"
}

variable "db_backup_period" {
  description = "Backup period (e.g., Monday,Wednesday,Friday)"
  type        = string
  default     = "Monday,Wednesday,Friday"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.24.6"
}

variable "worker_instance_type" {
  description = "Worker node instance type"
  type        = string
  default     = "ecs.g6.xlarge"
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
  default     = "172.17.0.0/16"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "vpc_payment_type" {
  description = "Payment type for VPC resources"
  type        = string
  default     = "PostPaid"
}

variable "vpc_internet_charge_type" {
  description = "Internet charge type for NAT Gateway"
  type        = string
  default     = "PayByBandwidth"
}

variable "db_security_ips" {
  description = "List of IP addresses allowed to access the database"
  type        = list(string)
  default     = []
}

variable "db_instance_charge_type" {
  description = "Database instance charge type"
  type        = string
  default     = "Postpaid"
}

variable "k8s_worker_disk_size" {
  description = "Size of the worker node disk"
  type        = number
  default     = 40
}

variable "k8s_worker_disk_category" {
  description = "Category of the worker node disk"
  type        = string
  default     = "cloud_essd"
}

variable "k8s_instance_types" {
  description = "List of instance types for the node pool"
  type        = list(string)
  default     = ["ecs.g6.xlarge"]
}

variable "k8s_desired_size" {
  description = "Desired number of nodes in the node pool"
  type        = number
  default     = 2
}

variable "k8s_system_disk_category" {
  description = "System disk category for the nodes"
  type        = string
  default     = "cloud_efficiency"
}

variable "k8s_system_disk_size" {
  description = "System disk size in GB for the nodes"
  type        = number
  default     = 40
}

variable "k8s_key_name" {
  description = "SSH key name for the nodes"
  type        = string
  default     = ""
}

variable "k8s_image_id" {
  description = "Image ID for the nodes"
  type        = string
  default     = ""
}

variable "k8s_password" {
  description = "Password for the nodes"
  type        = string
  default     = ""
  sensitive   = true
}

variable "k8s_install_cloud_monitor" {
  description = "Whether to install cloud monitor"
  type        = bool
  default     = true
}

variable "k8s_min_size" {
  description = "Minimum number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "k8s_max_size" {
  description = "Maximum number of nodes in the node pool"
  type        = number
  default     = 10
}

variable "k8s_is_bond_eip" {
  description = "Whether to bind EIP to the nodes"
  type        = bool
  default     = false
}

variable "k8s_eip_internet_charge_type" {
  description = "Internet charge type for EIP"
  type        = string
  default     = "PayByBandwidth"
}

variable "k8s_eip_bandwidth" {
  description = "Bandwidth for EIP"
  type        = number
  default     = 5
}

variable "k8s_auto_repair" {
  description = "Whether to enable auto repair"
  type        = bool
  default     = true
}

variable "k8s_auto_upgrade" {
  description = "Whether to enable auto upgrade"
  type        = bool
  default     = true
}

variable "k8s_surge" {
  description = "Number of extra nodes for surge"
  type        = number
  default     = 1
}

variable "k8s_max_unavailable" {
  description = "Maximum number of unavailable nodes during upgrade"
  type        = number
  default     = 1
}

variable "kubernetes_security_group_description" {
  description = "Description for the Kubernetes security group"
  type        = string
  default     = "Security group for Kubernetes cluster"
}

variable "kubernetes_security_group_ingress_rules" {
  description = "List of ingress rules for the Kubernetes security group"
  type = list(object({
    type              = string
    ip_protocol       = string
    nic_type          = string
    policy            = string
    port_range        = string
    priority          = number
    cidr_ip           = string
  }))
  default = [
    {
      type              = "ingress"
      ip_protocol       = "all"
      nic_type          = "intranet"
      policy            = "accept"
      port_range        = "-1/-1"
      priority          = 1
      cidr_ip           = "10.0.0.0/16"  # Will be replaced with vpc_cidr
    },
    {
      type              = "ingress"
      ip_protocol       = "tcp"
      nic_type          = "internet"
      policy            = "accept"
      port_range        = "22/22"
      priority          = 2
      cidr_ip           = "0.0.0.0/0"
    },
    {
      type              = "ingress"
      ip_protocol       = "tcp"
      nic_type          = "internet"
      policy            = "accept"
      port_range        = "6443/6443"
      priority          = 3
      cidr_ip           = "0.0.0.0/0"
    }
  ]
}

variable "kubernetes_security_group_egress_rules" {
  description = "List of egress rules for the Kubernetes security group"
  type = list(object({
    type              = string
    ip_protocol       = string
    nic_type          = string
    policy            = string
    port_range        = string
    priority          = number
    cidr_ip           = string
  }))
  default = [
    {
      type              = "egress"
      ip_protocol       = "all"
      nic_type          = "internet"
      policy            = "accept"
      port_range        = "-1/-1"
      priority          = 1
      cidr_ip           = "0.0.0.0/0"
    }
  ]
}

variable "ram_user_name" {
  description = "Name of the RAM user"
  type        = string
  default     = "k8s-admin"
}

variable "ram_user_display_name" {
  description = "Display name of the RAM user"
  type        = string
  default     = "Kubernetes Administrator"
}

variable "ram_user_force" {
  description = "Whether to force delete the RAM user"
  type        = bool
  default     = true
}

variable "ram_policies" {
  description = "List of RAM policies to attach to the user"
  type = list(object({
    policy_name = string
    policy_type = string
  }))
  default = [
    {
      policy_name = "AliyunContainerServiceFullAccess"
      policy_type = "System"
    },
    {
      policy_name = "AliyunECSFullAccess"
      policy_type = "System"
    }
  ]
}

variable "db_security_group_description" {
  description = "Description for the database security group"
  type        = string
  default     = "Security group for RDS instance"
}

variable "db_security_group_ingress_rules" {
  description = "List of ingress rules for the database security group"
  type = list(object({
    type              = string
    ip_protocol       = string
    nic_type          = string
    policy            = string
    port_range        = string
    priority          = number
    cidr_ip           = string
  }))
  default = [
    {
      type              = "ingress"
      ip_protocol       = "tcp"
      nic_type          = "intranet"
      policy            = "accept"
      port_range        = "3306/3306"
      priority          = 1
      cidr_ip           = "10.0.0.0/16"  # Will be replaced with vpc_cidr
    }
  ]
}

variable "db_security_group_egress_rules" {
  description = "List of egress rules for the database security group"
  type = list(object({
    type              = string
    ip_protocol       = string
    nic_type          = string
    policy            = string
    port_range        = string
    priority          = number
    cidr_ip           = string
  }))
  default = []
}

variable "k8s_tags" {
  description = "Tags to be applied to all Kubernetes resources"
  type        = map(string)
  default     = {}
}

variable "k8s_disable_cloud_monitor" {
  description = "Whether to disable cloud-monitor addon"
  type        = bool
  default     = false
}

variable "k8s_disable_csi_plugin" {
  description = "Whether to disable csi-plugin addon"
  type        = bool
  default     = false
}

variable "k8s_disable_ingress_nginx" {
  description = "Whether to disable nginx-ingress-controller addon"
  type        = bool
  default     = false
}

variable "k8s_disable_logtail_ds" {
  description = "Whether to disable logtail-ds addon"
  type        = bool
  default     = false
}

variable "k8s_disable_metrics_server" {
  description = "Whether to disable metrics-server addon"
  type        = bool
  default     = false
}

variable "k8s_disable_arms_prometheus" {
  description = "Whether to disable arms-prometheus addon"
  type        = bool
  default     = false
}

variable "k8s_ingress_nginx_version" {
  description = "Version of ingress-nginx addon"
  type        = string
  default     = "v1.8.0"
}

variable "k8s_csi_version" {
  description = "Version of CSI addon"
  type        = string
  default     = "v1.24.6"  # Should match k8s version
}

variable "k8s_metrics_server_version" {
  description = "Version of metrics-server addon"
  type        = string
  default     = "v0.6.4"
} 