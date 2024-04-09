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
  description = "Settings for the private dns"
  type = object({
    name                         = string
    resource_group_key           = optional(string)
    location                     = optional(string)
    version                      = string
    sku_name                     = string
    storage_mb                   = optional(number)
    auto_grow_enabled            = optional(bool)
    create_mode                  = optional(string, "Default")
    backup_retention_days        = optional(number)
    geo_redundant_backup_enabled = optional(bool)
    administrator_login          = optional(string, "edostawczak")
    zone                         = optional(string, "1")
    high_availability = optional(object({
      mode                      = string
      standby_availability_zone = optional(string)
    }))
    custom_configuration = optional(map(string), {})
    databases            = set(string)
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the private DNS"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "The map containing Private DNS Zones"
  type        = map(string)
  default     = {}
}

variable "delegated_subnet_id" {
  description = "The ID of the delegated subnet"
  type        = string
}

variable "key_vault_id" {
  description = "The ID of the key vault where the admin password should be stored"
  type    = string
}