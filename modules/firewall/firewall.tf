resource "azurerm_public_ip" "public_ip" {
  name                = azurecaf_name.pip.result
  resource_group_name = var.resource_group_name
  location            = coalesce(var.settings.location, var.global_settings.default_location)

  allocation_method = var.settings.public_ip.allocation_method
  sku               = var.settings.public_ip.sku
  sku_tier          = var.settings.public_ip.sku_tier
}

resource "azurerm_firewall" "firewall" {
  name                = azurecaf_name.fw.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  sku_name            = var.settings.firewall.sku_name
  sku_tier            = var.settings.firewall.sku_tier

  ip_configuration {
    name                 = format("%s-ip_configuration", azurecaf_name.fw.result)
    subnet_id            = lookup(var.subnets, var.settings.firewall.subnet_key)
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  dns_servers       = var.settings.firewall.dns_servers
  threat_intel_mode = var.settings.firewall.threat_intel_mode
  zones             = var.settings.firewall.zones
}