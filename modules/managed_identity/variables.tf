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
  description = "Settings for the managed identity"
  type = object({
    name               = string
    location           = optional(string)
    resource_group_key = optional(string)
    federated_credentials = optional(map(object({
      name     = string
      audience = string
      issuer   = string
      subject  = string
    })))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the managed identity"
  type        = string
}