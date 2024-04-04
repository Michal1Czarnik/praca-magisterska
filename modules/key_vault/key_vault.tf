resource "azurerm_key_vault" "key_vault" {
  name                = azurecaf_name.kv.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id

  sku_name                        = var.settings.sku_name
  enabled_for_deployment          = var.settings.enabled_for_deployment
  enabled_for_disk_encryption     = var.settings.enabled_for_disk_encryption
  enabled_for_template_deployment = var.settings.enabled_for_template_deployment

  purge_protection_enabled      = true
  public_network_access_enabled = false
  soft_delete_retention_days    = var.settings.soft_delete_retention_days

  enable_rbac_authorization = true

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}

resource "azurerm_role_assignment" "key_vault_permissions" {
  for_each = var.settings.rbac_permissions == null ? {} : var.settings.rbac_permissions

  scope                = azurerm_key_vault.key_vault.id
  role_definition_name = each.value
  principal_id         = try(var.ad_groups[each.key], var.managed_identities[each.key].managed_identity.principal_id, "")
}