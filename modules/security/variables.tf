variable "name_prefix" {
  description = "Prefix to be used on all resources"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
} 

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}