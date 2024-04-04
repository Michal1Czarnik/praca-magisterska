resource "azurerm_resource_group" "resource_group" {
  name     = azurecaf_name.rg.result
  location = coalesce(var.settings.location, var.global_settings.default_location)
}