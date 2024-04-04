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
    name                         = string
    location                     = optional(string)
    resource_group_key           = string
    sku_tier                     = optional(string)
    kubernetes_version           = optional(string)
    private_cluster_enabled      = bool
    dns_prefix                   = optional(string)
    image_cleaner_enabled        = optional(bool)
    image_cleaner_interval_hours = optional(number)
    oidc_issuer_enabled          = optional(bool)
    workload_identity_enabled    = optional(bool)
    nginx_ingress_enabled        = optional(bool, false)
    nginx_private_ip             = optional(string)
    default_node_pool = object({
      name                         = string
      vm_size                      = string
      enable_node_public_ip        = optional(bool)
      enable_auto_scaling          = optional(bool)
      max_pods                     = optional(number)
      only_critical_addons_enabled = optional(bool)
      orchestrator_version         = optional(string)
      os_disk_size_gb              = optional(number)
      os_disk_type                 = optional(string)
      os_sku                       = optional(string)
      vnet_subnet_key              = string
      temporary_name_for_rotation  = optional(string)
      type                         = optional(string)
      node_count                   = number
    })
    network_profile = optional(object({
      network_plugin = string
      network_mode   = optional(string)
      network_policy = optional(string)
      outbound_type  = optional(string)
      service_cidr   = optional(string)
      dns_service_ip = optional(string)
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(set(string))
    }))
    key_vault_secrets_provider = optional(object({
      secret_rotation_enabled  = optional(bool)
      secret_rotation_interval = optional(string)
    }))
    kubelet_identity = optional(object({
      client_id                 = optional(string)
      object_id                 = optional(string)
      user_assigned_identity_id = optional(string)
    }))
    ingress_application_gateway = optional(object({
      gateway_id   = optional(string)
      gateway_name = optional(string)
      subnet_cidr  = optional(string)
      subnet_id    = optional(string)
    }))
    additional_node_pools = optional(object({
      name       = string
      vm_size    = string
      node_count = number
    }))
  })
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the key vault"
  type        = string
}

variable "subnets" {
  description = "The map containing subnets"
  type        = map(string)
  default     = {}
}

variable "private_dns_zone_id" {
  description = "The Private DNS Zones ID"
  type        = string
}