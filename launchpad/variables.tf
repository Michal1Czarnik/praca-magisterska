variable "resource_groups" {
  description = "The map containing the resource groups that need to be created"
  type        = any
  default     = {}
}

variable "managed_identities" {
  description = "The map containing the managed identites that need to be created"
  type        = any
  default     = {}
}

variable "ad_users" {
  description = "The set of user principal names of everyone who should have access to resources"
  type        = set(string)
  default     = []
}

variable "ad_groups" {
  description = "The set of string containg groups to create in AAD"
  type        = set(string)
  default     = []
}

variable "ad_group_members" {
  description = "The map of object containg group members"
  type = map(object({
    user       = string
    group_name = string
  }))
  default = {}
}