# NOTE: firewall is not needed for now

module "firewall" {
  source = "../../modules/firewall"

  count = var.firewall == {} ? 0 : 1

  global_settings     = data.terraform_remote_state.launchpad.outputs.global_settings
  settings            = var.firewall
  resource_group_name = module.resource_group["networking"].name
  subnets             = module.virtual_network["hub"].subnet_id
}

module "destination_addresses_fw" {
  source = "../../modules/diagnostic_settings"

  target_resource_id         = module.firewall[0].id
  log_analytics_workspace_id = module.logging.id
}