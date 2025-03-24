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

variable "security_group_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for Kubernetes cluster"
}

variable "ingress_rules" {
  description = "List of ingress rules"
  type = list(object({
    type              = string
    ip_protocol       = string
    nic_type          = string
    policy            = string
    port_range        = string
    priority          = number
    cidr_ip           = string
  }))
  default = [
    {
      type              = "ingress"
      ip_protocol       = "all"
      nic_type          = "intranet"
      policy            = "accept"
      port_range        = "-1/-1"
      priority          = 1
      cidr_ip           = "10.0.0.0/16"  # This will be overridden by vpc_cidr
    }
  ]
}

variable "egress_rules" {
  description = "List of egress rules"
  type = list(object({
    type              = string
    ip_protocol       = string
    nic_type          = string
    policy            = string
    port_range        = string
    priority          = number
    cidr_ip           = string
  }))
  default = [
    {
      type              = "egress"
      ip_protocol       = "all"
      nic_type          = "internet"
      policy            = "accept"
      port_range        = "-1/-1"
      priority          = 1
      cidr_ip           = "0.0.0.0/0"
    }
  ]
}