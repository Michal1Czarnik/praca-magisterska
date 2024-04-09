resource "azurerm_public_ip" "public_ip" {
  count = var.settings.public_ip == null ? 0 : 1

  name                = azurecaf_name.pip[0].result
  resource_group_name = var.resource_group_name
  location            = coalesce(var.settings.location, var.global_settings.default_location)

  allocation_method = var.settings.public_ip.allocation_method
  sku               = var.settings.public_ip.sku
  sku_tier          = var.settings.public_ip.sku_tier
}

resource "azurerm_virtual_network_gateway" "virtual_network_gateway" {
  name                = azurecaf_name.vgw.result
  resource_group_name = var.resource_group_name
  location            = coalesce(var.settings.location, var.global_settings.default_location)

  type       = var.settings.virtual_network_gateway.type
  vpn_type   = var.settings.virtual_network_gateway.vpn_type
  sku        = var.settings.virtual_network_gateway.sku
  generation = var.settings.virtual_network_gateway.generation

  active_active = var.settings.virtual_network_gateway.active_active
  enable_bgp    = var.settings.virtual_network_gateway.enable_bgp

  ip_configuration {
    name                          = format("%s-ip_config", azurecaf_name.vgw.result)
    private_ip_address_allocation = var.settings.virtual_network_gateway.ip_configuration.private_ip_address_allocation
    subnet_id                     = var.subnets[var.settings.virtual_network_gateway.ip_configuration.subnet_key]
    public_ip_address_id          = var.settings.public_ip != null ? azurerm_public_ip.public_ip[0].id : null
  }


  vpn_client_configuration {
    address_space = var.settings.virtual_network_gateway.vpn_client_configuration.address_space

    aad_tenant   = var.settings.virtual_network_gateway.vpn_client_configuration.aad_tenant
    aad_audience = var.settings.virtual_network_gateway.vpn_client_configuration.aad_audience
    aad_issuer   = var.settings.virtual_network_gateway.vpn_client_configuration.aad_issuer

    vpn_client_protocols = var.settings.virtual_network_gateway.vpn_client_configuration.vpn_client_protocols
    vpn_auth_types       = var.settings.virtual_network_gateway.vpn_client_configuration.vpn_auth_types
  }

  # dynamic "custom_route" {
  #   for_each = var.settings.virtual_network_gateway.custom_route
  #   content {
  #     address_prefixes = custom_route.value.address_prefixes
  #   }
  # }
}