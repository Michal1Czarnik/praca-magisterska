resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = azurecaf_name.log.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  sku                 = var.settings.sku
  retention_in_days   = var.settings.retention_in_days
  daily_quota_gb      = var.settings.daily_quota_gb
}