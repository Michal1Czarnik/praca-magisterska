
resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  name                       = "diagnostic_settings" # not supported by CAF
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories.log_category_groups == null ? [] : toset(data.azurerm_monitor_diagnostic_categories.categories.log_category_groups)
    content {
      category_group = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.categories.metrics == null ? [] : toset(data.azurerm_monitor_diagnostic_categories.categories.metrics)
    content {
      category = metric.value
    }
  }
}