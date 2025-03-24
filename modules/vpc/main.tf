locals {
  # Create both private and public vswitches for each availability zone
  vswitches = merge(
    # Private vswitches
    {
      for i, az in var.availability_zones : "private_${az}" => {
        name     = "${var.name_prefix}-private-${az}"
        cidr     = cidrsubnet(var.vpc_cidr, 8, i)
        zone_id  = az
        is_private = true
      }
    },
    # Public vswitches
    {
      for i, az in var.availability_zones : "public_${az}" => {
        name     = "${var.name_prefix}-public-${az}"
        cidr     = cidrsubnet(var.vpc_cidr, 8, i + length(var.availability_zones))
        zone_id  = az
        is_private = false
      }
    }
  )
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr
  tags = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch

resource "alicloud_vswitch" "vswitches" {
  for_each = local.vswitches

  vswitch_name = each.value.name
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = each.value.cidr
  zone_id      = each.value.zone_id
  tags         = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/nat_gateway
resource "alicloud_nat_gateway" "nat" {
  vpc_id            = alicloud_vpc.vpc.id
  nat_gateway_name  = "${var.name_prefix}-nat-gateway"
  payment_type      = var.payment_type
  vswitch_id        = alicloud_vswitch.vswitches["public_${var.availability_zones[0]}"].id
  nat_type          = "Enhanced"
  tags              = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_address
resource "alicloud_eip_address" "nat" {
  address_name         = "${var.name_prefix}-nat-eip"
  bandwidth           = var.nat_bandwidth
  internet_charge_type = var.internet_charge_type
  payment_type        = var.payment_type
  tags                = var.tags
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/eip_association
resource "alicloud_eip_association" "nat" {
  allocation_id = alicloud_eip_address.nat.id
  instance_id   = alicloud_nat_gateway.nat.id
}

# https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/snat_entry
resource "alicloud_snat_entry" "private_vswitches" {
  for_each = {
    for k, v in local.vswitches : k => v
    if v.is_private
  }

  snat_table_id     = alicloud_nat_gateway.nat.snat_table_ids
  source_vswitch_id = alicloud_vswitch.vswitches[each.key].id
  snat_ip           = alicloud_eip_address.nat.ip_address
} 