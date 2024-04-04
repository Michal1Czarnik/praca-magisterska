resource "azurerm_virtual_network_peering" "virtual_network_peering" {
  name                      = azurecaf_name.vpeer.result
  virtual_network_name      = var.settings.virtual_network_name
  remote_virtual_network_id = var.settings.remote_virtual_network_id
  resource_group_name       = var.resource_group_name

  allow_virtual_network_access = var.settings.allow_virtual_network_access
  allow_forwarded_traffic      = var.settings.allow_forwarded_traffic
  allow_gateway_transit        = var.settings.allow_gateway_transit
  use_remote_gateways          = var.settings.use_remote_gateways
  triggers                     = var.settings.triggers
}