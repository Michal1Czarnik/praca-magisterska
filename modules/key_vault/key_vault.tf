resource "azurerm_key_vault" "key_vault" {
  name                = azurecaf_name.kv.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name                        = var.settings.sku_name
  enabled_for_deployment          = var.settings.enabled_for_deployment
  enabled_for_disk_encryption     = var.settings.enabled_for_disk_encryption
  enabled_for_template_deployment = var.settings.enabled_for_template_deployment

  purge_protection_enabled      = var.settings.purge_protection_enabled
  public_network_access_enabled = var.settings.public_network_access_enabled
  soft_delete_retention_days    = var.settings.soft_delete_retention_days

  enable_rbac_authorization = true

  dynamic "network_acls" {
    for_each = var.settings.network_acls == null ? [] : [var.settings.network_acls]
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules
      virtual_network_subnet_ids = [for value in network_acls.value.virtual_network_subnet_keys : var.subnets[value]]
    }
  }
}

resource "azurerm_role_assignment" "key_vault_permissions" {
  for_each = var.settings.rbac_permissions == null ? {} : var.settings.rbac_permissions

  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = each.value
  principal_id         = try(var.ad_groups[each.key], var.managed_identities[each.key].managed_identity.principal_id, "")
}