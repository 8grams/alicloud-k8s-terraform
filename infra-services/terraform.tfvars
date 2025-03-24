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

# Database Security Group Configuration
db_security_group_description = "Security group for RDS instance"

db_security_group_ingress_rules = [
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

db_security_group_egress_rules = []

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
k8s_auto_repair = true
k8s_auto_upgrade = true
k8s_surge = 1
k8s_max_unavailable = 1

# Kubernetes Addon Versions
k8s_ingress_nginx_version = "v1.8.0"
k8s_csi_version = "v1.24.6"
k8s_metrics_server_version = "v0.6.4"

# Common Tags
tags = {
  Environment = "production"
  Terraform   = "true"
  Project     = "k8s-cluster"
}

kubernetes_security_group_description = "Security group for Kubernetes cluster"

kubernetes_security_group_ingress_rules = [
  {
    type              = "ingress"
    ip_protocol       = "all"
    nic_type          = "intranet"
    policy            = "accept"
    port_range        = "10.0.0.0/16"  # Will be replaced with vpc_cidr
  }
]

kubernetes_security_group_egress_rules = [
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

# Kubernetes Tags
k8s_tags = {
  Environment = "production"
  ManagedBy   = "terraform"
}

# Kubernetes Addon Configuration
k8s_disable_cloud_monitor     = false  # Keep enabled for monitoring
k8s_disable_csi_plugin       = false  # Keep enabled for storage
k8s_disable_ingress_nginx    = false  # Keep enabled for ingress
k8s_disable_logtail_ds       = false  # Keep enabled for logging
k8s_disable_metrics_server   = false  # Keep enabled for HPA
k8s_disable_arms_prometheus  = false  # Keep enabled for monitoring

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
