# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user
resource "alicloud_ram_user" "k8s_user" {
  name         = "${var.name_prefix}-k8s-admin"
  display_name = "Kubernetes Administrator"
  force        = true
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_access_key
resource "alicloud_ram_access_key" "k8s_key" {
  user_name = alicloud_ram_user.k8s_user.name
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user_policy_attachment
resource "alicloud_ram_user_policy_attachment" "k8s_policy_1" {
  policy_name = "AliyunContainerServiceFullAccess"
  policy_type = "System"
  user_name   = alicloud_ram_user.k8s_user.name
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ram_user_policy_attachment
resource "alicloud_ram_user_policy_attachment" "k8s_policy_2" {
  policy_name = "AliyunECSFullAccess"
  policy_type = "System"
  user_name   = alicloud_ram_user.k8s_user.name
} 