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
    public_ip = optional(object({
      allocation_method = string
      sku               = optional(string)
      sku_tier          = optional(string)
    }))
    virtual_network_gateway = object({
      type          = string
      vpn_type      = optional(string)
      sku           = string
      generation    = optional(string)
      active_active = optional(string)
      enable_bgp    = optional(string)
      ip_configuration = object({
        private_ip_address_allocation = string
        subnet_key                    = string
      })
      vpn_client_configuration = optional(object({
        address_space        = set(string)
        aad_tenant           = optional(string)
        aad_audience         = optional(string)
        aad_issuer           = optional(string)
        vpn_client_protocols = optional(set(string))
        vpn_auth_types       = optional(set(string))
      }))
      # custom_route = optional(object({
      #   address_prefixes = optional(set(string))
      # }), {})
    })
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Virtual Network"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
  default     = {}
}