region = "ap-southeast-5"
vpc_cidr = "10.0.0.0/16"
name_prefix = "pintar"

# VPC Configuration
nat_bandwidth = 5
availability_zones = ["ap-southeast-5a", "ap-southeast-5b"]
vpc_payment_type = "PayAsYouGo"
vpc_internet_charge_type = "PayByBandwidth"

# Database Configuration
db_engine_version = "8.0"
db_instance_type = "mysql.n2.small.2c"
db_instance_storage = 20
db_username = "admin"
db_password = "your-secure-password"
db_backup_retention_period = 7
db_backup_time = "02:00Z-03:00Z"
db_backup_period = ["Monday", "Wednesday", "Friday"]
db_security_ips = ["0.0.0.0/0"]  # Allow access from anywhere, modify as needed
db_instance_charge_type = "Postpaid"

# Kubernetes Configuration
k8s_version = "1.24.6"
worker_instance_type = "ecs.g6.xlarge"
worker_nodes_count = 2
pod_cidr = "172.16.0.0/16"
service_cidr = "172.17.0.0/16"
k8s_worker_disk_size = 40
k8s_worker_disk_category = "cloud_essd"
k8s_instance_types = ["ecs.g6.xlarge"]
k8s_desired_size = 2
k8s_min_size = 1
k8s_max_size = 10
k8s_system_disk_category = "cloud_efficiency"
k8s_system_disk_size = 40
k8s_key_name = ""
k8s_image_id = ""
k8s_password = ""
k8s_install_cloud_monitor = true
k8s_is_bond_eip = false
k8s_eip_internet_charge_type = "PayByBandwidth"
k8s_eip_bandwidth = 5
k8s_auto_repair = true
k8s_auto_upgrade = true
k8s_surge = 1
k8s_max_unavailable = 1

# Common Tags
tags = {
  Environment = "production"
  Terraform   = "true"
  Project     = "k8s-cluster"
}

security_group_description = "Security group for Kubernetes cluster"

security_group_ingress_rules = [
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

security_group_egress_rules = [
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

# RAM Configuration
ram_user_name = "k8s-admin"
ram_user_display_name = "Kubernetes Administrator"
ram_user_force = true
ram_policies = [
  {
    policy_name = "AliyunContainerServiceFullAccess"
    policy_type = "System"
  },
  {
    policy_name = "AliyunECSFullAccess"
    policy_type = "System"
  }
]
