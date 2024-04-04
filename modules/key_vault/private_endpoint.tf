module "private_endpoint" {
  source = "../private_endpoint"

  global_settings = var.global_settings

  resource_group_name            = var.resource_group_name
  subnets                        = var.subnets
  private_connection_resource_id = azurerm_key_vault.key_vault.id
  private_dns_zone_ids           = var.private_dns_zone_ids
  settings                       = var.settings.private_endpoint
}