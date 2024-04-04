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
    sku                = optional(string)
    retention_in_days  = optional(number)
    daily_quota_gb     = optional(number)
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Security Rule"
  type        = string
}