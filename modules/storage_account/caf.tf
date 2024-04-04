resource "azurecaf_name" "st" {
  name          = var.settings.name
  resource_type = "azurerm_storage_account"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "stct" {
  for_each = var.settings.storage_container == null ? [] : var.settings.storage_container

  name          = each.value
  resource_type = "azurerm_storage_container"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}