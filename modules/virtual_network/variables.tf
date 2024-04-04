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
    name               = string
    location           = optional(string)
    resource_group_key = string
    address_space      = string
    dns_servers        = optional(set(string))
    subnet = map(object({
      name              = string
      caf_passthrough   = optional(bool)
      address_prefixes  = set(string)
      service_endpoints = optional(set(string))
      delegation = optional(object({
        name         = string
        service_name = string
        actions      = optional(set(string))
      }))
    }))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Virtual Network"
  type        = string
}