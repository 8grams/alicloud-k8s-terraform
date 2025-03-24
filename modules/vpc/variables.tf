variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones (e.g., ['ap-southeast-5a', 'ap-southeast-5b'])"
  type        = list(string)
}

variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
  default     = "k8s"
}

variable "nat_bandwidth" {
  description = "Bandwidth for NAT Gateway"
  type        = number
  default     = 10
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "payment_type" {
  description = "Payment type for NAT Gateway"
  type        = string
  default     = "PayAsYouGo"
}

variable "internet_charge_type" {
  description = "Internet charge type for NAT Gateway"
  type        = string
  default     = "PayByBandwidth"
}