resource "azurecaf_name" "vnet" {
  name = var.settings.name

  resource_type = "azurerm_virtual_network"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "snet" {
  for_each = var.settings.subnet

  name          = each.value.name
  resource_type = "azurerm_subnet"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = coalesce(each.value.caf_passthrough, var.global_settings.passthrough)
  use_slug      = var.global_settings.use_slug
}