resource "azurerm_public_ip" "public_ip" {
  name                = azurecaf_name.pip.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}


resource "azurerm_application_gateway" "application_gateway" {
  name                = azurecaf_name.agw.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name

  enable_http2                      = true
  force_firewall_policy_association = true
  firewall_policy_id                = try(azurerm_web_application_firewall_policy.waf_policy.id, null)

  tags = { "app" = "test" }

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 1
  }

  backend_address_pool {
    name = "aksbackendpool"
  }

  backend_http_settings {
    name                  = "initial"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
  }

  frontend_ip_configuration {
    name                 = "frontendconfig"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

  frontend_port {
    name = "frontend80"
    port = 80
  }

  gateway_ip_configuration {
    name      = "gatewayipconfig"
    subnet_id = var.subnets["appgw"]
  }

  http_listener {
    name                           = "listener"
    frontend_ip_configuration_name = "frontendconfig"
    frontend_port_name             = "frontend80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "reqroutingrule"
    rule_type                  = "Basic"
    http_listener_name         = "listener"
    backend_address_pool_name  = "aksbackendpool"
    backend_http_settings_name = "initial"
    priority                   = 10000
  }
  lifecycle {
    ignore_changes = [
      sku,
      backend_address_pool,
      backend_http_settings,
      frontend_ip_configuration,
      frontend_port,
      gateway_ip_configuration,
      http_listener,
      request_routing_rule,
      tags,
      probe
    ]
  }
}