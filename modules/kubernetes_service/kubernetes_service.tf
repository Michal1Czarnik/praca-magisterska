resource "azurerm_kubernetes_cluster" "kubernetes_cluster" {
  name                = azurecaf_name.aks.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name

  sku_tier                = var.settings.sku_tier
  kubernetes_version      = var.settings.kubernetes_version
  private_cluster_enabled = var.settings.private_cluster_enabled
  private_dns_zone_id     = var.private_dns_zone_id

  dns_prefix                 = var.settings.dns_prefix
  dns_prefix_private_cluster = var.settings.dns_prefix == null ? azurecaf_name.aks.result : null

  image_cleaner_enabled        = var.settings.image_cleaner_enabled
  image_cleaner_interval_hours = var.settings.image_cleaner_interval_hours

  oidc_issuer_enabled       = var.settings.oidc_issuer_enabled
  workload_identity_enabled = var.settings.workload_identity_enabled


  default_node_pool {
    name                         = var.settings.default_node_pool.name
    vm_size                      = var.settings.default_node_pool.vm_size
    enable_node_public_ip        = var.settings.default_node_pool.enable_node_public_ip
    enable_auto_scaling          = var.settings.default_node_pool.enable_auto_scaling
    max_pods                     = var.settings.default_node_pool.max_pods
    only_critical_addons_enabled = var.settings.default_node_pool.only_critical_addons_enabled
    orchestrator_version         = var.settings.default_node_pool.orchestrator_version == null ? var.settings.kubernetes_version : var.settings.default_node_pool.orchestrator_version
    os_disk_size_gb              = var.settings.default_node_pool.os_disk_size_gb
    os_disk_type                 = var.settings.default_node_pool.os_disk_type
    os_sku                       = var.settings.default_node_pool.os_sku
    vnet_subnet_id               = var.subnets[var.settings.default_node_pool.vnet_subnet_key]
    temporary_name_for_rotation  = var.settings.default_node_pool.temporary_name_for_rotation
    type                         = var.settings.default_node_pool.type
    node_count                   = var.settings.default_node_pool.node_count
  }

  dynamic "network_profile" {
    for_each = var.settings.network_profile == null ? [] : [var.settings.network_profile]
    content {
      network_plugin = network_profile.value.network_plugin
      network_mode   = network_profile.value.network_mode
      network_policy = network_profile.value.network_policy
      outbound_type  = network_profile.value.outbound_type
      service_cidr   = network_profile.value.service_cidr
      dns_service_ip = network_profile.value.dns_service_ip
    }
  }

  dynamic "identity" {
    for_each = var.settings.identity == null ? [] : [var.settings.identity]
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.settings.key_vault_secrets_provider == null ? [] : [var.settings.key_vault_secrets_provider]
    content {
      secret_rotation_enabled  = key_vault_secrets_provider.value.secret_rotation_enabled
      secret_rotation_interval = key_vault_secrets_provider.value.secret_rotation_interval
    }
  }

  dynamic "kubelet_identity" {
    for_each = var.settings.kubelet_identity == null ? [] : [var.settings.kubelet_identity]
    content {
      client_id                 = kubelet_identity.value.client_id
      object_id                 = kubelet_identity.value.object_id
      user_assigned_identity_id = kubelet_identity.value.user_assigned_identity_id
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = var.settings.ingress_application_gateway == null ? [] : [var.settings.ingress_application_gateway]
    content {
      gateway_id   = ingress_application_gateway.value.gateway_id
      gateway_name = ingress_application_gateway.value.gateway_name
      subnet_cidr  = ingress_application_gateway.value.subnet_cidr
      subnet_id    = ingress_application_gateway.value.subnet_id
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pool" {
  for_each = var.settings.additional_node_pools == null ? {} : var.settings.additional_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = azurerm_kubernetes_cluster.kubernetes_cluster.id
  vm_size               = each.value.vm_size
  node_count            = each.value.node_count
}