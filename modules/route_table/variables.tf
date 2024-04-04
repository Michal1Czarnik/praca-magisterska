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
    name                          = string
    location                      = optional(string)
    resource_group_key            = optional(string)
    disable_bgp_route_propagation = optional(bool)
    route = set(object({
      name                   = string
      address_prefix         = string
      next_hop_type          = string
      next_hop_in_ip_address = string
    }))

  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  type        = string
}