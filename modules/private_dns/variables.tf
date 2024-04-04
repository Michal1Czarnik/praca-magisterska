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
    name                 = string
    resource_group_key   = optional(string)
    virtual_network_key  = optional(string)
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the private DNS"
  type        = string
}