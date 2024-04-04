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
  description = "Settings for the nsg"
  type = object({
    name               = string
    resource_group_key = string
    location           = optional(string)
    network_security_rule = map(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = optional(string)
      destination_port_range     = optional(string)
      source_address_prefix      = optional(string)
      destination_address_prefix = optional(string)
      destination_port_ranges    = optional(list(string))
    }))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Security Rule"
  type        = string
}