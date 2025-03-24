variable "name_prefix" {
  description = "Prefix to be used for resource names"
  type        = string
  default     = "k8s"
}

variable "vswitch_ids" {
  description = "List of vswitch IDs for the database"
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
  default     = "mysql.n2.small.2c"
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
  description = "Database password"
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
  type        = array(string)
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