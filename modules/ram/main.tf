# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user
resource "alicloud_ram_user" "k8s_user" {
  name         = "${var.name_prefix}-${var.ram_user_name}"
  display_name = var.ram_user_display_name
  force        = var.ram_user_force
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_access_key
resource "alicloud_ram_access_key" "k8s_key" {
  user_name = alicloud_ram_user.k8s_user.name
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user_policy_attachment
resource "alicloud_ram_user_policy_attachment" "k8s_policies" {
  for_each = {
    for idx, policy in var.ram_policies : idx => policy
  }

  policy_name = each.value.policy_name
  policy_type = each.value.policy_type
  user_name   = alicloud_ram_user.k8s_user.name
} 