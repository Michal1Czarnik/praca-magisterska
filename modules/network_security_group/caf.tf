resource "azurecaf_name" "nsg" {
  name          = var.settings.name
  resource_type = "azurerm_network_security_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}