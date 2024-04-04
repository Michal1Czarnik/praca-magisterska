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