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
  databases                 = var.databases
  tags                      = var.tags
}

module "kubernetes" {
  source = "../modules/kubernetes"

  depends_on            = [ module.ram ]
  name_prefix           = var.name_prefix
  k8s_version           = var.k8s_version
  vswitch_ids           = module.vpc.private_vswitch_ids
  pod_vswitch_ids       = module.vpc.pod_vswitch_ids
  security_group_id     = module.kubernetes_security_group.security_group_id
  worker_instance_type  = var.worker_instance_type
  worker_disk_category  = var.k8s_worker_disk_category
  worker_disk_size      = var.k8s_worker_disk_size

  # Node pool configuration
  instance_types          = var.k8s_instance_types
  system_disk_category    = var.k8s_system_disk_category
  system_disk_size        = var.k8s_system_disk_size
  key_name                = var.k8s_key_name
  image_id                = var.k8s_image_id
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

  # autoscaler configuration
  cool_down_duration            = var.k8s_autoscaler_cool_down_duration
  unneeded_duration             = var.k8s_autoscaler_unneeded_duration
  utilization_threshold         = var.k8s_autoscaler_utilization_threshold
  scan_interval                 = var.k8s_autoscaler_scan_interval
  scale_down_enabled            = var.k8s_autoscaler_scale_down_enabled
  expander                      = var.k8s_autoscaler_expander
  skip_nodes_with_system_pods   = var.k8s_autoscaler_skip_nodes_with_system_pods
  skip_nodes_with_local_storage = var.k8s_autoscaler_skip_nodes_with_local_storage
  daemonset_eviction_for_nodes  = var.k8s_autoscaler_daemonset_eviction_for_nodes
  max_graceful_termination_sec  = var.k8s_autoscaler_max_graceful_termination_sec
  min_replica_count             = var.k8s_autoscaler_min_replica_count
  recycle_node_deletion_enabled = var.k8s_autoscaler_recycle_node_deletion_enabled
  scale_up_from_zero            = var.k8s_autoscaler_scale_up_from_zero
  scaler_type                   = var.k8s_autoscaler_scaler_type

  tags = var.k8s_tags
}

module "storage_production" {
  source = "../modules/storage"

  vpc_id        = module.vpc.vpc_id
  tags          = var.tags
  bucket_name   = var.storage_production_bucket_name
  storage_class = var.storage_class
  sse_algorithm = var.storage_sse_algorithm
  versioning_enabled        = var.storage_versioning_enabled
  lifecycle_noncurrent_version_expiration_days = var.storage_lifecycle_noncurrent_version_expiration_days
}

module "storage_staging" {
  source = "../modules/storage"

  vpc_id        = module.vpc.vpc_id
  tags          = var.tags
  bucket_name   = var.storage_staging_bucket_name
  storage_class = var.storage_class
  sse_algorithm = var.storage_sse_algorithm

  versioning_enabled        = var.storage_versioning_enabled
  lifecycle_noncurrent_version_expiration_days = var.storage_lifecycle_noncurrent_version_expiration_days
}

# ===============================================
# bastion
module "bastion_vm_security_group" {
  source = "../modules/security-group"

  name_prefix = "bastion-vm"
  vpc_id      = module.vpc.vpc_id
  vpc_cidr    = module.vpc.vpc_cidr
  
  security_group_description = "Security group for VM instance"
  ingress_rules = [
    {
      type        = "ingress"
      port_range  = "22/22"
      protocol    = "tcp"
      cidr_ip     = "0.0.0.0/0"
      priority    = 1
      ip_protocol = "all"
      nic_type    = "intranet"
      policy      = "accept"
    },
    {
      type        = "ingress"
      port_range  = "80/80"
      protocol    = "tcp"
      cidr_ip     = "0.0.0.0/0"
      priority    = 1
      ip_protocol = "all"
      nic_type    = "intranet"
      policy      = "accept"
    },
    {
      type        = "ingress"
      port_range  = "443/443"
      protocol    = "tcp"
      cidr_ip     = "0.0.0.0/0"
      priority    = 1
      ip_protocol = "all"
      nic_type    = "intranet"
      policy      = "accept"
    }
  ]
  egress_rules = var.kubernetes_security_group_egress_rules
  
  tags = var.tags
}

module "bastion_key_pair" {
  source = "../modules/key-pair"

  key_name    = var.bastion_key_name
  tags        = var.tags
}

module "bastion_vm" {
  source = "../modules/vm"

  instance_name     = var.bastion_instance_name
  vswitch_id        = module.vpc.other_vswitch_ids[0]
  security_group_id = module.bastion_vm_security_group.security_group_id
  instance_type     = var.bastion_instance_type
  key_name          = module.bastion_key_pair.key_name
  tags              = var.tags
}
# ===============================================

# Save kubeconfig to a file
resource "local_sensitive_file" "kubeconfig" {
  depends_on = [module.kubernetes]
  content    = <<EOF
apiVersion: v1
clusters:
- cluster:
    server: ${module.kubernetes.cluster_endpoint}
    certificate-authority-data: ${module.kubernetes.cluster_cert}
  name: ack-cluster
contexts:
- context:
    cluster: ack-cluster
    user: ack-user
  name: ack-context
current-context: ack-context
kind: Config
preferences: {}
users:
- name: ack-user
  user:
    client-certificate-data: ${module.kubernetes.client_cert}
    client-key-data: ${module.kubernetes.client_key}
EOF
  filename   = "${path.module}/kubeconfig.yaml"
}