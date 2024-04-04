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
  source = "../../modules/diagnostic_settings"

  for_each = var.virtual_networks

  target_resource_id         = module.virtual_network[each.key].virtual_network_id
  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id
}

module "virtual_network_peering_spoke_to_hub" {
  source = "../../modules/virtual_network_peering"

  for_each = var.virtual_networks

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = {
    name                      = each.value.name
    virtual_network_name      = module.virtual_network[each.key].virtual_network_name
    remote_virtual_network_id = data.terraform_remote_state.hub.outputs.vnet_hub_id
    use_remote_gateways       = true
    allow_forwarded_traffic   = true
  }
  resource_group_name = module.resource_group["networking"].name
}

module "virtual_network_peering_hub_to_spoke" {
  source = "../../modules/virtual_network_peering"

  for_each = var.virtual_networks

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = {
    name                      = each.value.name
    virtual_network_name      = data.terraform_remote_state.hub.outputs.vnet_hub_name
    remote_virtual_network_id = module.virtual_network[each.key].virtual_network_id
    allow_gateway_transit     = true
  }
  resource_group_name = data.terraform_remote_state.hub.outputs.vnet_hub_rg
}