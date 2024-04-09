variable "resource_groups" {
  description = "The map containing the resource groups that need to be created"
  type        = any
  default     = {}
}

variable "postgresql_servers" {
  description = "The map containing the postgresql servers that need to be created"
  type        = any
  default     = {}
}

variable "kubernetes_services" {
  description = "The map containing the kubernetes clusters that need to be created"
  type        = any
  default     = {}
}

variable "appgw_enabled" {
  description = "Is AppGW enabled?"
  type = bool
  default     = false
}