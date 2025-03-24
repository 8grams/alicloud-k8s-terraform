variable "name_prefix" {
  description = "Prefix to be used on all resources"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to all resources"
  type        = map(string)
  default     = {}
}

variable "ram_user_name" {
  description = "Name of the RAM user"
  type        = string
  default     = "k8s-admin"
}

variable "ram_user_display_name" {
  description = "Display name of the RAM user"
  type        = string
  default     = "Kubernetes Administrator"
}

variable "ram_user_force" {
  description = "Whether to force delete the RAM user"
  type        = bool
  default     = true
}

variable "ram_policies" {
  description = "List of RAM policies to attach to the user"
  type = list(object({
    policy_name = string
    policy_type = string
  }))
  default = [
    {
      policy_name = "AliyunContainerServiceFullAccess"
      policy_type = "System"
    },
    {
      policy_name = "AliyunECSFullAccess"
      policy_type = "System"
    }
  ]
} 