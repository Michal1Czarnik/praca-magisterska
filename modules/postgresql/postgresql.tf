resource "azurerm_postgresql_flexible_server" "postgresql_flexible_server" {
  #checkov:skip=CKV_AZURE_136:in vars

  name                = var.settings.name # not supported by caf
  resource_group_name = var.resource_group_name
  location            = coalesce(var.settings.location, var.global_settings.default_location)

  version           = var.settings.version
  sku_name          = var.settings.sku_name
  storage_mb        = var.settings.storage_mb
  auto_grow_enabled = var.settings.auto_grow_enabled
  create_mode       = var.settings.create_mode
  zone              = var.settings.zone

  backup_retention_days        = var.settings.backup_retention_days
  geo_redundant_backup_enabled = var.settings.geo_redundant_backup_enabled

  delegated_subnet_id = var.delegated_subnet_id
  private_dns_zone_id = var.private_dns_zone_ids["postgres"]

  administrator_login    = var.settings.administrator_login
  administrator_password = azurerm_key_vault_secret.key_vault_secret.value

  dynamic "high_availability" {
    for_each = var.settings.high_availability == null ? [] : [var.settings.high_availability]
    content {
      mode                      = high_availability.value.mode
      standby_availability_zone = high_availability.value.standby_availability_zone
    }
  }
}

resource "azurerm_postgresql_flexible_server_configuration" "postgresql_flexible_server_configuration" {
  for_each = var.settings.custom_configuration

  name      = each.key
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  value     = each.value
}

resource "azurerm_postgresql_flexible_server_database" "postgresql_flexible_server_database" {
  for_each = var.settings.databases

  name      = each.value
  server_id = azurerm_postgresql_flexible_server.postgresql_flexible_server.id
  collation = "en_US.utf8" # default
  charset   = "utf8"       # default
}