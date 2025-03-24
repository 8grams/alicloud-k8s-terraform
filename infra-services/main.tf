module "vpc" {
  source = "../modules/vpc"

  name_prefix           = var.name_prefix
  vpc_name              = "${var.name_prefix}-vpc"
  vpc_cidr              = var.vpc_cidr
  nat_bandwidth         = var.nat_bandwidth
  availability_zones    = var.availability_zones
  payment_type          = var.vpc_payment_type
  internet_charge_type  = var.vpc_internet_charge_type
  tags                  = var.tags
}

module "security_group" {
  source = "../modules/security-group"

  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
  tags        = var.tags
}

module "ram" {
  source = "../modules/ram"

  name_prefix = var.name_prefix
  tags        = var.tags
}

module "database" {
  source = "../modules/database"

  name_prefix               = var.name_prefix
  vswitch_ids               = module.vpc.private_vswitch_ids
  engine_version            = var.db_engine_version
  instance_type             = var.db_instance_type
  instance_storage          = var.db_instance_storage
  db_username               = var.db_username
  db_password               = var.db_password
  backup_retention_period   = var.db_backup_retention_period
  backup_time               = var.db_backup_time
  backup_period             = var.db_backup_period
  security_ips              = var.db_security_ips
  instance_charge_type      = var.db_instance_charge_type
  tags                      = var.tags
}

module "kubernetes" {
  source = "../modules/kubernetes"

  name_prefix        = var.name_prefix
  cluster_id         = module.kubernetes.cluster_id
  k8s_version        = var.k8s_version
  vswitch_ids        = module.vpc.private_vswitch_ids
  pod_vswitch_ids    = module.vpc.private_vswitch_ids
  security_group_id  = module.security_group.security_group_id
  
  # Worker node configuration
  worker_instance_type = var.worker_instance_type
  worker_nodes_count   = var.worker_nodes_count
  worker_disk_size     = var.k8s_worker_disk_size
  worker_disk_category = var.k8s_worker_disk_category
  
  # Network configuration
  pod_cidr     = var.pod_cidr
  service_cidr = var.service_cidr
  
  # Node pool configuration
  instance_types       = var.k8s_instance_types
  desired_size         = var.k8s_desired_size
  min_size             = var.k8s_min_size
  max_size             = var.k8s_max_size
  system_disk_category = var.k8s_system_disk_category
  system_disk_size     = var.k8s_system_disk_size
  
  # Node access configuration
  key_name  = var.k8s_key_name
  image_id  = var.k8s_image_id
  password  = var.k8s_password
  
  # EIP configuration
  is_bond_eip              = var.k8s_is_bond_eip
  eip_internet_charge_type = var.k8s_eip_internet_charge_type
  eip_bandwidth            = var.k8s_eip_bandwidth
  
  # Node pool management
  install_cloud_monitor = var.k8s_install_cloud_monitor
  auto_repair           = var.k8s_auto_repair
  auto_upgrade          = var.k8s_auto_upgrade
  surge                 = var.k8s_surge
  max_unavailable       = var.k8s_max_unavailable
  
  tags = var.tags
} 