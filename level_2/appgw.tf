module "application_gateway" {
  source = "../modules/application_gateway"

  count = var.appgw_enabled ? 1 : 0

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = {
    name = "appgw"
  }
  resource_group_name = module.resource_group["app"].name
  subnets             = data.terraform_remote_state.spoke.outputs.spoke_subnets
}

module "diagnostic_settings_appgw" {
  source = "../modules/diagnostic_settings"

  count = var.appgw_enabled ? 1 : 0

  target_resource_id         = module.application_gateway[0].id
  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id
}

resource "azurerm_role_assignment" "acig_sub_reader" {
  count = var.appgw_enabled ? 1 : 0

  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
  principal_id         = module.kubernetes_service["app"].agic_mi_id
}

resource "azurerm_role_assignment" "acig_appgw_contributor" {
  count = var.appgw_enabled ? 1 : 0

  scope                = module.application_gateway[0].id
  role_definition_name = "Contributor"
  principal_id         = module.kubernetes_service["app"].agic_mi_id
}

resource "azurerm_role_assignment" "acig_network_contributor" {
  count = var.appgw_enabled ? 1 : 0

  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Network Contributor"
  principal_id         = module.kubernetes_service["app"].agic_mi_id
}