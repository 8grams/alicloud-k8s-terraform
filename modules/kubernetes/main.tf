# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_managed_kubernetes
resource "alicloud_cs_managed_kubernetes" "cluster" {
  name                 = "${var.name_prefix}-k8s-cluster"
  version              = var.k8s_version
  vswitch_ids          = var.vswitch_ids
  pod_vswitch_ids      = var.pod_vswitch_ids
  security_group_id    = var.security_group_id
  
  # Networking
  slb_internet_enabled = true
  service_cidr         = var.service_cidr
  
  # Container Network
  proxy_mode            = "ipvs"
  
  # Addons configuration
  addons {
    name     = "terway-eniip"
    disabled = var.disable_terway_eniip
    config   = jsonencode({})
  }

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
    name     = "csi-provisioner"
    disabled = var.disable_csi_provisioner
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
  cluster_id                  = alicloud_cs_managed_kubernetes.cluster.id
  node_pool_name              = "${var.name_prefix}-node-pool"
  vswitch_ids                 = var.vswitch_ids
  instance_types              = var.instance_types
  system_disk_category        = var.system_disk_category
  system_disk_size            = var.system_disk_size
  key_name                    = var.key_name
  image_type                  = "AliyunLinux3"
  install_cloud_monitor       = var.install_cloud_monitor

  data_disks {
    category      = var.worker_disk_category
    size          = var.worker_disk_size
    name          = "worker-data-disk"
    auto_format   = true
    mount_target  = "/mnt"
    file_system   = "ext4"
  }

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

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_autoscaling_config
resource "alicloud_cs_autoscaling_config" "default" {
  cluster_id                    = alicloud_cs_managed_kubernetes.cluster.id
  cool_down_duration            = var.cool_down_duration
  unneeded_duration             = var.unneeded_duration
  utilization_threshold         = var.utilization_threshold
  scan_interval                 = var.scan_interval
  scale_down_enabled            = var.scale_down_enabled
  expander                      = var.expander
  skip_nodes_with_system_pods   = var.skip_nodes_with_system_pods
  skip_nodes_with_local_storage = var.skip_nodes_with_local_storage
  daemonset_eviction_for_nodes  = var.daemonset_eviction_for_nodes
  max_graceful_termination_sec  = var.max_graceful_termination_sec
  min_replica_count             = var.min_replica_count
  recycle_node_deletion_enabled = var.recycle_node_deletion_enabled
  scale_up_from_zero            = true
  scaler_type                   = "goatscaler"
}

# Kubernetes Addons
# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/cs_kubernetes_addon

resource "alicloud_cs_kubernetes_addon" "ingress_nginx" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "nginx-ingress-controller"
  config     = jsonencode({
    IngressSlbNetworkType = "internet"
    IngressSlbSpec        = "slb.s2.small"
  })
}

resource "alicloud_cs_kubernetes_addon" "csi" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "csi-plugin"
  config     = jsonencode({})
}

resource "alicloud_cs_kubernetes_addon" "csi_provisioner" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "csi-provisioner"
  config     = jsonencode({})
}


resource "alicloud_cs_kubernetes_addon" "metrics_server" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "metrics-server"
  config     = jsonencode({})
}

# Monitoring Configuration
resource "alicloud_cs_kubernetes_addon" "prometheus" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "arms-prometheus"
  config     = jsonencode({
    enabled = "true"
  })
}

resource "alicloud_cs_kubernetes_addon" "log_service" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "logtail-ds"
  config     = jsonencode({
    IngressDashboardEnabled = "true"
  })
} 

resource "alicloud_cs_kubernetes_addon" "terway-eniip" {
  cluster_id = alicloud_cs_managed_kubernetes.cluster.id
  name       = "terway-eniip"
  config     = jsonencode({})
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role
resource "alicloud_ram_role" "autoscaler" {
  name        = "AliyunCSManagedAutoscalerRole"
  document    = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "cs.aliyuncs.com"
        ]
      }
    }
  ],
  "Version": "1"
}
EOF
  description = "Role for Container Service managed node pool autoscaling"
  force       = true
}

resource "alicloud_ram_policy" "autoscaler" {
  policy_name = "AliyunCSManagedAutoScalerRolePolicy"
  policy_document = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": "cs:*",
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": "ram:PassRole",
      "Resource": "*",
      "Effect": "Allow",
      "Condition": {
        "StringEquals": {
          "acs:Service": "cs.aliyuncs.com"
        }
      }
    }
  ]
}
EOF
  description = "Policy for autoscaler role used in Container Service"
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_role_policy_attachment
resource "alicloud_ram_role_policy_attachment" "autoscaler" {
  count = var.create_autoscaler_policy ? 1 : 0

  role_name   = alicloud_ram_role.autoscaler.name
  policy_name = alicloud_ram_policy.autoscaler.policy_name
  policy_type = "Custom"
}

# Create default RAM role for Kubernetes
resource "alicloud_ram_role" "default" {
  name        = "AliyunCSDefaultRole"
  document    = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "cs.aliyuncs.com"
        ]
      }
    }
  ],
  "Version": "1"
}
EOF
  description = "Default role for Container Service"
  force       = true
}

# Create default policy for the role
resource "alicloud_ram_policy" "default" {
  policy_name = "AliyunCSDefaultRolePolicy"
  policy_document = <<EOF
{
  "Version": "1",
  "Statement": [
    {
      "Action": [
        "cs:*",
        "vpc:*",
        "ecs:*",
        "slb:*",
        "ess:*",
        "ram:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
  description = "Default policy for Container Service with VPC permissions"
}

# Attach default policy to role
resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.name
  policy_name = alicloud_ram_policy.default.policy_name
  policy_type = "Custom"
}