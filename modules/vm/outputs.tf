output "instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.vm.id
}

output "instance_name" {
  description = "The name of the ECS instance"
  value       = alicloud_instance.vm.instance_name
}

output "public_ip" {
  description = "The public IP address of the ECS instance"
  value       = alicloud_instance.vm.public_ip
}

output "private_ip" {
  description = "The private IP address of the ECS instance"
  value       = alicloud_instance.vm.private_ip
}
