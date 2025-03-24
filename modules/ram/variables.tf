variable "name_prefix" {
  description = "Prefix to be used on all resources"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
} 