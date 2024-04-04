resource "azurerm_private_dns_zone" "private_dns_zone" {
  name                = azurecaf_name.pdns.result
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_virtual_network_link" {
  name                  = format("%s-vnet_link", azurecaf_name.pdns.result)
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = var.settings.virtual_network_id
  registration_enabled  = var.settings.registration_enabled
}