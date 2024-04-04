module "logging" {
  source = "../../modules/log_analytics"

  global_settings     = data.terraform_remote_state.launchpad.outputs.global_settings
  settings            = var.logging
  resource_group_name = module.resource_group[var.logging.resource_group_key].name
}