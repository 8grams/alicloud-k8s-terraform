variable "name_prefix" {
  description = "Prefix to be used on all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
}

variable "vswitch_id" {
  description = "The ID of the vswitch to place the RDS instance in"
  type        = string
}

variable "db_instance_type" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "mysql.n2.small.2c"
}

variable "db_instance_storage" {
  description = "The storage size in GB of the RDS instance"
  type        = number
  default     = 20
}

variable "db_account_name" {
  description = "The name of the database account"
  type        = string
  default     = "admin"
}

variable "db_account_password" {
  description = "The password of the database account"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    Environment = "production"
    Terraform   = "true"
  }
} 