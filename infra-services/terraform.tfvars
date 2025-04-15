region = "ap-southeast-5"
vpc_cidr = "10.0.0.0/16"
name_prefix = "ali"

# VPC Configuration
nat_bandwidth = 5
availability_zones = ["ap-southeast-5a", "ap-southeast-5b"]
vpc_payment_type = "PayAsYouGo"
vpc_internet_charge_type = "PayByTraffic"

# Database Configuration
db_engine_version = "8.0"
db_instance_type = "rds.mysql.s1.small"
db_instance_storage = 20
db_username = "your-mysql-username"
db_password = "your-mysql-password"
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
    cidr_ip           = "10.0.0.0/16"
  }
]

db_security_group_egress_rules = []

databases = [
  {
    name = "production"
  },
  {
    name = "staging"
  }
]
# Kubernetes Configuration
k8s_version = "1.32.1-aliyun.1"
worker_instance_type = "ecs.g6.xlarge"
k8s_worker_disk_size = 40
k8s_worker_disk_category = "cloud_essd"
k8s_instance_types = ["ecs.g8i.xlarge"]
k8s_min_size = 2
k8s_max_size = 2
k8s_system_disk_category = "cloud_essd"
k8s_system_disk_size = 40
k8s_key_name = ""
k8s_image_id = ""
k8s_auto_repair = true
k8s_auto_upgrade = true
k8s_surge = 1
k8s_max_unavailable = 1

# cluster auto scaling
k8s_autoscaler_cool_down_duration = "10m"
k8s_autoscaler_unneeded_duration = "10m"
k8s_autoscaler_utilization_threshold = "0.7"
k8s_autoscaler_scan_interval = "30s"
k8s_autoscaler_scale_down_enabled = true
k8s_autoscaler_expander = "least-waste"
k8s_autoscaler_skip_nodes_with_system_pods = true
k8s_autoscaler_skip_nodes_with_local_storage = false
k8s_autoscaler_daemonset_eviction_for_nodes = false
k8s_autoscaler_max_graceful_termination_sec = 14400
k8s_autoscaler_min_replica_count = 0
k8s_autoscaler_recycle_node_deletion_enabled = false
k8s_autoscaler_scale_up_from_zero = true
k8s_autoscaler_scaler_type = "goatscaler"

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
    port_range        = "1/65535"
    priority          = 1
    cidr_ip           = "10.0.0.0/16"
  }
]

kubernetes_security_group_egress_rules = [
  {
    type              = "egress"
    ip_protocol       = "all"
    nic_type          = "intranet"
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
    policy_name = "AliyunCSFullAccess"
    policy_type = "System"
  },
  {
    policy_name = "AliyunECSFullAccess"
    policy_type = "System"
  }
]

bastion_instance_name = "bastion-vm"
bastion_instance_type = "ecs.g6.large"
bastion_key_name      = "bastion-ssh-key"

# storage configuration
storage_production_bucket_name = "my-production-bucket"
storage_staging_bucket_name = "my-staging-bucket"
storage_class = "Standard"
storage_sse_algorithm = "AES256"
storage_versioning_enabled = true
storage_lifecycle_noncurrent_version_expiration_days = 30
