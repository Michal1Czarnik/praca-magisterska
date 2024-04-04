resource "azurerm_firewall_application_rule_collection" "application_rule_collection" {
  for_each = var.settings.application_rule_collections == null ? {} : var.settings.application_rule_collections

  name                = azurecaf_name.fwapp[each.key].result
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rule

    content {
      name             = rule.key
      source_addresses = rule.value.source_addresses
      target_fqdns     = rule.value.target_fqdns

      dynamic "protocol" {
        for_each = rule.value.protocol == null ? {} : rule.value.protocol

        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  for_each = var.settings.network_rule_collections == null ? {} : var.settings.network_rule_collections

  name                = azurecaf_name.fwnetrc[each.key].result
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rule

    content {
      name                  = rule.key
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}

