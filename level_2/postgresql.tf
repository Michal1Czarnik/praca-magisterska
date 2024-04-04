module "postgresql" {
  source = "../modules/postgresql"

  for_each = var.postgresql_servers

  global_settings      = data.terraform_remote_state.launchpad.outputs.global_settings
  settings             = each.value
  resource_group_name  = module.resource_group[each.value.resource_group_key].name
  private_dns_zone_ids = data.terraform_remote_state.hub.outputs.private_dns_zone_ids
  delegated_subnet_id  = data.terraform_remote_state.spoke.outputs.spoke_subnets["postgresql_delegated"]
  key_vault_id         = data.terraform_remote_state.spoke.outputs.key_vault_id["common"]
}

module "postgresql_diagnostic_settings" {
  source = "../modules/diagnostic_settings"

  for_each = var.postgresql_servers

  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id
  target_resource_id         = module.postgresql[each.key].id
}