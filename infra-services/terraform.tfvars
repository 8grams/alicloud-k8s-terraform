region = "ap-southeast-5"
vpc_cidr = "10.0.0.0/16"
name_prefix = "pintar"

# VPC Configuration
nat_bandwidth = 5
availability_zones = ["ap-southeast-5a", "ap-southeast-5b"]

# Database Configuration
db_engine_version = "8.0"
db_instance_type = "mysql.n2.small.2c"
db_instance_storage = 20
db_username = "admin"
db_password = "your-secure-password"
db_backup_retention_period = 7
db_backup_time = "02:00Z-03:00Z"
db_backup_period = ["Monday", "Wednesday", "Friday"]

# Kubernetes Configuration
k8s_version = "1.24.6"
worker_instance_type = "ecs.g6.xlarge"
worker_nodes_count = 2
pod_cidr = "172.16.0.0/16"
service_cidr = "172.17.0.0/16"

# Common Tags
tags = {
  Environment = "production"
  Terraform   = "true"
  Project     = "k8s-cluster"
}
