module "private_endpoint" {
  source = "../private_endpoint"

  count = var.settings.private_endpoint == null ? 0 : 1

  global_settings = var.global_settings

  resource_group_name            = var.resource_group_name
  subnets                        = var.subnets
  private_connection_resource_id = azurerm_storage_account.storage_account.id
  private_dns_zone_ids           = var.private_dns_zone_ids
  settings                       = var.settings.private_endpoint
}