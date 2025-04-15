variable "bucket_name" {
  description = "Name of the OSS bucket"
  type        = string
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm"
  type        = string
  default     = "AES256"
}

variable "versioning_enabled" {
  description = "Whether to enable versioning"
  type        = bool
  default     = true
}

variable "lifecycle_noncurrent_version_expiration_days" {
  description = "Number of days before noncurrent versions expire"
  type        = number
  default     = 30
}

variable "vpc_id" {
  description = "ID of the VPC for bucket policy"
  type        = string
}

variable "storage_class" {
  description = "Storage class for the bucket"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
} 