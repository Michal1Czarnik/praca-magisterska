resource "azurerm_virtual_network" "virtual_network" {
  name                = azurecaf_name.vnet.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  address_space       = [var.settings.address_space]
  dns_servers         = var.settings.dns_servers
}