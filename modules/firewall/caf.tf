resource "azurecaf_name" "pip" {
  name          = var.settings.name
  resource_type = "azurerm_public_ip"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "fw" {
  name          = var.settings.name
  resource_type = "azurerm_firewall"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "fwapp" {
  for_each = var.settings.application_rule_collections == null ? {} : var.settings.application_rule_collections

  name          = each.value.name
  resource_type = "azurerm_firewall_application_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "fwnetrc" {
  for_each = var.settings.network_rule_collections == null ? {} : var.settings.network_rule_collections

  name          = each.value.name
  resource_type = "azurerm_firewall_network_rule_collection"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = var.global_settings.clean_input
  separator     = var.global_settings.separator
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}