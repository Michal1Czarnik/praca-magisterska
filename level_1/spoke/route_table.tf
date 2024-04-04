module "route_table" {
  source = "../../modules/route_table"

  for_each = var.route_tables

  global_settings     = data.terraform_remote_state.launchpad.outputs.global_settings
  settings            = each.value
  resource_group_name = module.resource_group[each.value.resource_group_key].name
}

resource "azurerm_subnet_route_table_association" "route_table_association" {
  for_each = var.route_table_associations

  subnet_id      = module.virtual_network[each.value.virtual_network_key].subnet_id[each.value.subnet_key]
  route_table_id = module.route_table[each.value.route_table_key].id
}