output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = alicloud_vpc.vpc.cidr_block
}

output "private_vswitch_ids" {
  description = "List of private vswitch IDs"
  value = [
    for k, v in alicloud_vswitch.vswitches : v.id
    if v.is_private
  ]
}

output "public_vswitch_ids" {
  description = "List of public vswitch IDs"
  value = [
    for k, v in alicloud_vswitch.vswitches : v.id
    if !v.is_private
  ]
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = alicloud_nat_gateway.nat.id
}

output "eip_address" {
  description = "The IP address of the EIP"
  value       = alicloud_eip.nat.ip_address
} 