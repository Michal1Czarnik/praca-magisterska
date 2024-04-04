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
  description = "Settings for the virtual network"
  type = object({
    name                         = string
    virtual_network_name         = string
    remote_virtual_network_id    = string
    allow_virtual_network_access = optional(bool)
    allow_forwarded_traffic      = optional(bool)
    allow_gateway_transit        = optional(bool)
    use_remote_gateways          = optional(bool)
    triggers                     = optional(map(string))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Virtual Network"
  type        = string
}