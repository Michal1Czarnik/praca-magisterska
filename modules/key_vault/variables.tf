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
  description = "Settings for the key vault"
  type = object({
    name                            = string
    location                        = optional(string)
    resource_group_key              = string
    sku_name                        = string
    enabled_for_deployment          = optional(string)
    enabled_for_disk_encryption     = optional(string)
    enabled_for_template_deployment = optional(string)
    purge_protection_enabled        = optional(bool)
    public_network_access_enabled   = optional(bool)
    soft_delete_retention_days      = optional(number)
    enable_rbac_authorization       = optional(bool)
    rbac_permissions                = optional(map(string))
    network_acls = optional(object({
      bypass                      = string
      default_action              = string
      ip_rules                    = optional(set(string))
      virtual_network_subnet_keys = optional(set(string))
    }))
    private_endpoint = any
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault"
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
}

variable "private_dns_zone_ids" {
  description = "The map containing Private DNS Zones"
  type        = map(string)
}

variable "ad_groups" {
  description = "The map containing AD groups"
  type        = map(string)
}

variable "managed_identities" {
  description = "The map containing managed identities"
  type        = any
}