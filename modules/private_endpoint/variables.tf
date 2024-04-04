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
  description = "Settings for the private endpoint"
  type = object({
    name       = string
    location   = optional(string)
    subnet_key = string
    private_service_connection = object({
      is_manual_connection = optional(bool, false)
      subresource_names    = optional(set(string))
    })
    private_dns_zone_group = optional(object({
      name                 = string
      private_dns_zone_key = set(string)
    }))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the private endpoint"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
}

variable "private_connection_resource_id" {
  description = "The resource ID for which private endpoint is needed"
  type        = string
}

variable "private_dns_zone_ids" {
  description = "The map containing private DNS zones"
}