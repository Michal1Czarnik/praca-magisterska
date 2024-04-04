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
    name               = string
    location           = optional(string)
    resource_group_key = optional(string)
    public_ip = object({
      allocation_method = string
      sku               = optional(string)
      sku_tier          = optional(string)
    })
    firewall = object({
      subnet_key        = string
      sku_name          = string
      sku_tier          = string
      dns_servers       = optional(list(string))
      threat_intel_mode = optional(string)
      zones             = optional(list(string))
    })
    application_rule_collections = optional(map(object({
      name     = string
      priority = number
      action   = string
      rule = map(object({
        source_addresses = list(string)
        target_fqdns     = list(string)
        protocol = optional(map(object({
          port = string
          type = string
        })))
      }))
    })))
    network_rule_collections = optional(map(object({
      name     = string
      priority = number
      action   = string
      rule = map(object({
        source_addresses      = list(string)
        destination_ports     = list(string)
        destination_addresses = list(string)
        protocols             = list(string)
      }))
    })))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
}