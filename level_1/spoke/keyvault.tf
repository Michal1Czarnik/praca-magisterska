module "key_vault" {
  source = "../../modules/key_vault"

  for_each = var.key_vaults

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings

  resource_group_name  = module.resource_group[each.value.resource_group_key].name
  subnets              = module.virtual_network["spoke"].subnet_id
  tenant_id            = data.azuread_client_config.current.tenant_id
  private_dns_zone_ids = data.terraform_remote_state.hub.outputs.private_dns_zone_ids

  settings = each.value

  ad_groups          = try(data.terraform_remote_state.launchpad.outputs.ad_groups_id, {})
  managed_identities = try(data.terraform_remote_state.launchpad.outputs.managed_identities, {})
}