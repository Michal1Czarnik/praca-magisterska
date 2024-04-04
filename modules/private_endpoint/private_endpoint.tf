resource "azurerm_private_endpoint" "private_endpoint" {
  name                = azurecaf_name.pe.result
  resource_group_name = var.resource_group_name
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  subnet_id           = var.subnets[var.settings.subnet_key]

  private_service_connection {
    name                           = format("%s-psc", azurecaf_name.pe.result)
    is_manual_connection           = var.settings.private_service_connection.is_manual_connection
    private_connection_resource_id = var.private_connection_resource_id
    subresource_names              = var.settings.private_service_connection.subresource_names
  }

  dynamic "private_dns_zone_group" {
    for_each = var.settings.private_dns_zone_group == null ? [] : [var.settings.private_dns_zone_group]
    content {
      name                 = private_dns_zone_group.value.name
      private_dns_zone_ids = [for value in private_dns_zone_group.value.private_dns_zone_key : var.private_dns_zone_ids[value]]
    }
  }
}