# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance
resource "alicloud_instance" "vm" {
  instance_name              = var.instance_name
  instance_type              = var.instance_type
  image_id                   = var.image_id
  vswitch_id                 = var.vswitch_id
  security_groups            = [var.security_group_id]
  key_name                   = var.key_name
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  internet_charge_type       = var.internet_charge_type
  instance_charge_type       = var.instance_charge_type
  user_data                  = var.user_data

  system_disk_category = var.system_disk_category
  system_disk_size     = var.system_disk_size

  tags = var.tags
}