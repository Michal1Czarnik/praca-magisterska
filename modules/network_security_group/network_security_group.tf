resource "azurerm_network_security_group" "network_security_group" {
  name                = azurecaf_name.nsg.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "network_security_rule" {
  for_each = var.settings.network_security_rule

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  destination_port_ranges     = each.value.destination_port_ranges
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.network_security_group.name
}

