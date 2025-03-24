# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group
resource "alicloud_security_group" "cluster_sg" {
  security_group_name = "${var.name_prefix}-security-group"
  vpc_id             = var.vpc_id
  description        = var.security_group_description
  tags               = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule
resource "alicloud_security_group_rule" "ingress_rules" {
  for_each = {
    for idx, rule in var.ingress_rules : idx => rule
  }

  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = each.value.nic_type
  policy            = each.value.policy
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.cluster_sg.id
  cidr_ip           = each.value.cidr_ip == "10.0.0.0/16" ? var.vpc_cidr : each.value.cidr_ip
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule
resource "alicloud_security_group_rule" "egress_rules" {
  for_each = {
    for idx, rule in var.egress_rules : idx => rule
  }

  type              = each.value.type
  ip_protocol       = each.value.ip_protocol
  nic_type          = each.value.nic_type
  policy            = each.value.policy
  port_range        = each.value.port_range
  priority          = each.value.priority
  security_group_id = alicloud_security_group.cluster_sg.id
  cidr_ip           = each.value.cidr_ip
} 