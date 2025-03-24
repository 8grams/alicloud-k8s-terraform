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
  
  # Addons configuration
  addons {
    name     = "cloud-monitor"
    disabled = var.disable_cloud_monitor
    config   = jsonencode({})
  }
  addons {
    name     = "csi-plugin"
    disabled = var.disable_csi_plugin
    config   = jsonencode({})
  }
  addons {
    name     = "nginx-ingress-controller"
    disabled = var.disable_ingress_nginx
    config   = jsonencode({})
  }
  addons {
    name     = "logtail-ds"
    disabled = var.disable_logtail_ds
    config   = jsonencode({})
  }
  addons {
    name     = "metrics-server"
    disabled = var.disable_metrics_server
    config   = jsonencode({})
  }
  addons {
    name     = "arms-prometheus"
    disabled = var.disable_arms_prometheus
    config   = jsonencode({})
  }
  
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

# Kubernetes Addons
# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_addon
resource "alicloud_cs_kubernetes_addon" "ingress_nginx" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "nginx-ingress-controller"
  version    = var.ingress_nginx_version
  config     = jsonencode({
    IngressSlbNetworkType = "internet"
    IngressSlbSpec        = "slb.s2.small"
  })
}

resource "alicloud_cs_kubernetes_addon" "csi" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "csi-plugin"
  version    = var.csi_version
  config     = jsonencode({})
}

resource "alicloud_cs_kubernetes_addon" "metrics_server" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "metrics-server"
  version    = var.metrics_server_version
  config     = jsonencode({})
}

# Monitoring Configuration
resource "alicloud_cs_kubernetes_addon" "prometheus" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "arms-prometheus"
  version    = "v0.5.1"  # Use latest stable version
  config     = jsonencode({
    enabled = "true"
  })
}

resource "alicloud_cs_kubernetes_addon" "arms" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "arms-agent"
  version    = "v0.1.2"  # Use latest stable version
  config     = jsonencode({
    enabled = "true"
  })
}

resource "alicloud_cs_kubernetes_addon" "log_service" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "logtail-ds"
  version    = "v1.0.30"  # Use latest stable version
  config     = jsonencode({
    IngressDashboardEnabled = "true"
  })
} 