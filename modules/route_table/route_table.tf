resource "azurerm_route_table" "route_table" {
  name                = azurecaf_name.route.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name

  disable_bgp_route_propagation = var.settings.disable_bgp_route_propagation

  dynamic "route" {
    for_each = var.settings.route
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}