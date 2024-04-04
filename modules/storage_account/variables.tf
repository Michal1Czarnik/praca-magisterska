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
    name                            = string
    location                        = optional(string)
    resource_group_key              = optional(string)
    account_kind                    = optional(string)
    account_tier                    = string
    account_replication_type        = string
    access_tier                     = optional(string)
    enable_https_traffic_only       = optional(bool, true)
    min_tls_version                 = optional(string, "TLS1_2")
    allow_nested_items_to_be_public = optional(bool, false)
    public_network_access_enabled   = optional(bool, false)
    is_hns_enabled                  = optional(bool)
    network_rules = optional(object({
      default_action             = string
      bypass                     = optional(set(string))
      ip_rules                   = optional(set(string))
      virtual_network_subnet_key = optional(set(string))
    }))
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