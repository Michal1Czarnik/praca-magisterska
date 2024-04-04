resource "azurecaf_name" "pip" {
  count = var.settings.public_ip == null ? 0 : 1

  name          = var.settings.name
  resource_type = "azurerm_public_ip"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "vgw" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
