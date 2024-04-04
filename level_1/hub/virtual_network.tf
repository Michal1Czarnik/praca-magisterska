module "virtual_network" {
  source = "../../modules/virtual_network"

  for_each = var.virtual_networks

  global_settings     = data.terraform_remote_state.launchpad.outputs.global_settings
  settings            = each.value
  resource_group_name = module.resource_group[each.value.resource_group_key].name
}


module "network_security_group" {
  source = "../../modules/network_security_group"

  for_each = var.network_security_groups

  global_settings     = data.terraform_remote_state.launchpad.outputs.global_settings
  settings            = each.value
  resource_group_name = module.resource_group[each.value.resource_group_key].name
}

resource "azurerm_subnet_network_security_group_association" "subnet_network_security_group_association" {
  for_each = var.subnet_network_security_group_associations == null ? {} : var.subnet_network_security_group_associations

  subnet_id                 = module.virtual_network[each.value.virtual_network_key].subnet_id[each.value.subnet_key]
  network_security_group_id = module.network_security_group[each.value.network_security_group_key].id
}

module "vnet_diagnostic_settings" {
  source   = "../../modules/diagnostic_settings"
  for_each = var.virtual_networks

  target_resource_id         = module.virtual_network[each.key].virtual_network_id
  log_analytics_workspace_id = module.logging.id
}