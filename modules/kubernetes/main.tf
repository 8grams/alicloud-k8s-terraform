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
  os_type             = "Linux"
  install_cloud_monitor = true
  proxy_mode         = "ipvs"
  
  # Terway network plugin configuration
  cluster_network_type = "terway-eni"
  
  # Tags
  tags = var.tags
} 