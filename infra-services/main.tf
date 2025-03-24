module "vpc" {
  source = "../modules/vpc"

  name_prefix         = var.name_prefix
  vpc_name            = "${var.name_prefix}-vpc"
  vpc_cidr            = var.vpc_cidr
  nat_bandwidth       = var.nat_bandwidth
  availability_zones  = var.availability_zones
}

module "security" {
  source = "../modules/security"

  name_prefix = var.name_prefix
  vpc_id     = module.vpc.vpc_id
  vpc_cidr   = module.vpc.vpc_cidr
}

module "database" {
  source = "../modules/database"

  name_prefix  = var.name_prefix
  vswitch_ids  = module.vpc.private_vswitch_ids
  db_password  = var.db_password
  tags         = var.tags
}

module "kubernetes" {
  source = "../modules/kubernetes"

  name_prefix        = var.name_prefix
  k8s_version       = var.k8s_version
  vswitch_ids       = module.vpc.private_vswitch_ids
  pod_vswitch_ids   = module.vpc.private_vswitch_ids
  security_group_id = module.security.security_group_id
  
  worker_instance_type = var.worker_instance_type
  worker_nodes_count  = var.worker_nodes_count
  pod_cidr           = var.pod_cidr
  service_cidr       = var.service_cidr
  tags              = var.tags
} 