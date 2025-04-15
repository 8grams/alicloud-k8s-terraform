variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
  default     = "k8s"
}

variable "vswitch_ids" {
  description = "List of vswitch IDs for the database"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the RDS instance"
  type        = list(string)
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "rds.mysql.s1.small"
}

variable "instance_storage" {
  description = "RDS instance storage in GB"
  type        = number
  default     = 20
}

variable "security_ips" {
  description = "List of IP addresses allowed to access the database"
  type        = list(string)
  default     = []
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the database account. Must be 8-32 characters long and contain at least three of the following: uppercase letters, lowercase letters, numbers, and special characters."
  type        = string
  sensitive   = true
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 7
}

variable "backup_time" {
  description = "Backup time in UTC"
  type        = string
  default     = "02:00Z-03:00Z"
}

variable "backup_period" {
  description = "Backup period (e.g., Monday,Wednesday,Friday)"
  type        = list(string)
  default     = ["Monday", "Wednesday", "Friday"]
}

variable "instance_charge_type" {
  description = "Instance charge type"
  type        = string
  default     = "Postpaid"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
} 

variable "storage_auto_scale" {
  description = "Whether to enable storage auto scale"
  type        = string
  default     = "Enable"
}

variable "storage_threshold" {
  description = "Storage threshold in percentage"
  type        = number
  default     = 50
}

variable "storage_upper_bound" {
  description = "Storage upper bound in GB"
  type        = number
  default     = 2000
}

variable "databases" {
  description = "List of databases to create"
  type = list(object({
    name = string
  }))
  default = []
}

variable "db_privileges" {
  description = "List of database privileges to grant to users"
  type = list(object({
    user       = string
    database   = string
    privileges = list(string)
  }))
  default = []
}