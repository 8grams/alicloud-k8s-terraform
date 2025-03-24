# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group
resource "alicloud_security_group" "cluster_sg" {
  security_group_name = "${var.name_prefix}-security-group"
  vpc_id             = var.vpc_id
  description        = "Security group for Kubernetes cluster"
  tags               = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule
resource "alicloud_security_group_rule" "allow_vpc_ingress" {
  type              = "ingress"
  ip_protocol       = "all"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.cluster_sg.id
  cidr_ip           = var.vpc_cidr
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule
resource "alicloud_security_group_rule" "allow_all_egress" {
  type              = "egress"
  ip_protocol       = "all"
  nic_type          = "internet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.cluster_sg.id
  cidr_ip           = "0.0.0.0/0"
} 