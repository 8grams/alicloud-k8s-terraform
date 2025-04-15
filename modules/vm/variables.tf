variable "instance_name" {
  description = "The name of the instance"
  type        = string
}

variable "vswitch_id" {
  description = "The ID of the VSwitch to which the instance belongs"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to which the instance belongs"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "ecs.g6.large"
}

variable "image_id" {
  description = "The ID of the image used to launch the instance"
  type        = string
  default     = "ubuntu_24_04_x64_20G_alibase_20250217.vhd"
}

variable "system_disk_category" {
  description = "The category of the system disk"
  type        = string
  default     = "cloud_efficiency"
}

variable "system_disk_size" {
  description = "The size of the system disk in GB"
  type        = number
  default     = 40
}

variable "key_name" {
  description = "The name of the key pair to use for the instance"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "internet_max_bandwidth_out" {
  description = "Maximum outgoing bandwidth to the public network, measured in Mbps"
  type        = number
  default     = 10
}

variable "internet_charge_type" {
  description = "Internet charge type of the instance"
  type        = string
  default     = "PayByTraffic"
}

variable "instance_charge_type" {
  description = "The charge type of instance"
  type        = string
  default     = "PostPaid"
}

variable "user_data" {
  description = "User data to provide when launching the instance"
  type        = string
  default     = ""
}

variable "payment_type" {
  description = "The payment type of the EIP"
  type        = string
  default     = "PayAsYouGo"
}
