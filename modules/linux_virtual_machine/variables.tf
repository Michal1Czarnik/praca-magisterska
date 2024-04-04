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
    name                = string
    resource_group_key  = string
    location            = optional(string)
    subnet_key          = string
    virtual_network_key = optional(string)
    private_ip_address  = optional(string)
    size                = string
    admin_username      = optional(string, "edostawczak")
    public_key          = string
    custom_data         = optional(string)
    dns_servers         = optional(set(string))

    os_disk = object({
      disk_size_gb         = optional(number)
      caching              = string
      storage_account_type = string
    })
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Network Security Rule"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
  default     = {}
}