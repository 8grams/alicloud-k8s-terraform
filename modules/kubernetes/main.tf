# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes
resource "alicloud_cs_managed_kubernetes" "cluster" {
  name                 = "${var.name_prefix}-k8s-cluster"
  version              = var.k8s_version
  vswitch_ids          = var.vswitch_ids
  pod_vswitch_ids      = var.pod_vswitch_ids
  security_group_id    = var.security_group_id
  
  # Worker nodes configuration
  worker_instance_types = [var.worker_instance_type]
  worker_number         = var.worker_nodes_count
  worker_data_disks {
    category = var.worker_disk_category
    size     = var.worker_disk_size
  }
  
  # Networking
  pod_cidr             = var.pod_cidr
  service_cidr         = var.service_cidr
  slb_internet_enabled = true
  
  # Container Network
  os_type               = "Linux"
  install_cloud_monitor = true
  proxy_mode            = "ipvs"
  
  # Terway network plugin configuration
  cluster_network_type = "terway-eni"
  
  # Tags
  tags = var.tags
} 

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_node_pool
resource "alicloud_cs_kubernetes_node_pool" "default" {
  cluster_id                  = var.cluster_id
  node_pool_name              = "${var.name_prefix}-node-pool"
  vswitch_ids                 = var.vswitch_ids
  instance_types              = var.instance_types
  desired_size                = var.desired_size
  system_disk_category        = var.system_disk_category
  system_disk_size            = var.system_disk_size
  key_name                    = var.key_name
  image_type                  = "AliyunLinux3"
  password                    = var.password
  install_cloud_monitor       = var.install_cloud_monitor

  scaling_config {
    min_size     = var.min_size
    max_size     = var.max_size
    type         = "cpu"
    is_bond_eip  = false
  }
  management {
    auto_repair     = var.auto_repair
    auto_upgrade    = var.auto_upgrade
    max_unavailable = var.max_unavailable
  }
  tags = var.tags
} 