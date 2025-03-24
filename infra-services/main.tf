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

module "kubernetes_security_group" {
  source = "../modules/security-group"

  name_prefix = var.name_prefix
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
  
  security_group_description  = var.kubernetes_security_group_description
  ingress_rules               = var.kubernetes_security_group_ingress_rules
  egress_rules                = var.kubernetes_security_group_egress_rules
  
  tags = var.tags
}

module "db_security_group" {
  source = "../modules/security-group"

  name_prefix = "${var.name_prefix}-db"
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
  
  security_group_description = var.db_security_group_description
  ingress_rules            = var.db_security_group_ingress_rules
  egress_rules             = var.db_security_group_egress_rules
  
  tags = var.tags
}

module "ram" {
  source = "../modules/ram"

  name_prefix = var.name_prefix
  tags        = var.tags
  
  ram_user_name         = var.ram_user_name
  ram_user_display_name = var.ram_user_display_name
  ram_user_force        = var.ram_user_force
  ram_policies          = var.ram_policies
}

module "database" {
  source = "../modules/database"

  name_prefix               = var.name_prefix
  vswitch_ids               = module.vpc.private_vswitch_ids
  security_group_ids        = [module.db_security_group.security_group_id]
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

  name_prefix           = var.name_prefix
  k8s_version           = var.k8s_version
  vswitch_ids           = module.vpc.vswitch_ids
  pod_vswitch_ids       = module.vpc.pod_vswitch_ids
  security_group_id     = module.kubernetes_security_group.security_group_id
  worker_instance_type  = var.worker_instance_type
  worker_nodes_count    = var.worker_nodes_count
  worker_disk_category  = var.k8s_worker_disk_category
  worker_disk_size      = var.k8s_worker_disk_size
  pod_cidr              = var.pod_cidr
  service_cidr          = var.service_cidr

  # Node pool configuration
  cluster_id              = module.kubernetes.cluster_id
  instance_types          = var.k8s_instance_types
  desired_size            = var.k8s_desired_size
  system_disk_category    = var.k8s_system_disk_category
  system_disk_size        = var.k8s_system_disk_size
  key_name                = var.k8s_key_name
  image_id                = var.k8s_image_id
  password                = var.k8s_password
  install_cloud_monitor   = var.k8s_install_cloud_monitor
  min_size                = var.k8s_min_size
  max_size                = var.k8s_max_size
  auto_repair             = var.k8s_auto_repair
  auto_upgrade            = var.k8s_auto_upgrade
  surge                   = var.k8s_surge
  max_unavailable         = var.k8s_max_unavailable

  # Addon configuration
  disable_cloud_monitor   = var.k8s_disable_cloud_monitor
  disable_csi_plugin      = var.k8s_disable_csi_plugin
  disable_ingress_nginx   = var.k8s_disable_ingress_nginx
  disable_logtail_ds      = var.k8s_disable_logtail_ds
  disable_metrics_server  = var.k8s_disable_metrics_server
  disable_arms_prometheus = var.k8s_disable_arms_prometheus
  ingress_nginx_version   = var.k8s_ingress_nginx_version
  csi_version             = var.k8s_csi_version
  metrics_server_version  = var.k8s_metrics_server_version

  tags = var.k8s_tags
} 