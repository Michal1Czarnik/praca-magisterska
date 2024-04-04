variable "global_settings" {
  description = "Global settings related to CAF"
  type = object({
    prefixes         = list(string)
    random_length    = number
    clean_input      = bool
    separator        = string
    passthrough      = bool
    use_slug         = bool
    default_location = optional(string)
  })
}

variable "settings" {
  description = "Settings for the storage account"
  type = object({
    name               = string
    location           = optional(string)
    resource_group_key = optional(string)
    account_kind       = optional(string)
    account_tier       = string
    access_tier        = optional(string)
    is_hns_enabled     = optional(bool)
    blob_properties = optional(object({
      versioning_enabled  = optional(bool)
      change_feed_enabled = optional(bool)
      delete_retention_policy = optional(object({
        days = number
      }))
      restore_policy = optional(object({
        days = number
      }))
    }))
    storage_container = optional(set(string))
    private_endpoint  = optional(any) # defined in the submodule
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_ids" {
  description = "The map containing Private DNS Zones"
  type        = map(string)
  default     = {}
}