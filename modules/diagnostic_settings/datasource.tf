data "azurerm_monitor_diagnostic_categories" "categories" {
  resource_id = var.target_resource_id
}