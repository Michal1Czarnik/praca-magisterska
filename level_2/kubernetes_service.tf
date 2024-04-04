module "kubernetes_service" {
  source = "../modules/kubernetes_service"

  for_each = var.kubernetes_services

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = merge(each.value,
    {
      identity = {
        type         = "UserAssigned"
        identity_ids = [data.terraform_remote_state.launchpad.outputs.managed_identities["aks_pool"].managed_identity.id]
      }
      kubelet_identity = {
        user_assigned_identity_id = data.terraform_remote_state.launchpad.outputs.managed_identities["aks_kubelet"].managed_identity.id
        client_id                 = data.terraform_remote_state.launchpad.outputs.managed_identities["aks_kubelet"].managed_identity.client_id
        object_id                 = data.terraform_remote_state.launchpad.outputs.managed_identities["aks_kubelet"].managed_identity.principal_id
      }
    },
    var.appgw_enabled ? { ingress_application_gateway = { gateway_id = module.application_gateway[0].id } } : {}
  )

  resource_group_name = module.resource_group[each.value.resource_group_key].name
  private_dns_zone_id = data.terraform_remote_state.hub.outputs.private_dns_zone_ids["aks"]
  subnets             = data.terraform_remote_state.spoke.outputs.spoke_subnets
}

module "kubernetes_service_diagnostic_settings" {
  source = "../modules/diagnostic_settings"

  for_each = var.kubernetes_services

  target_resource_id         = module.kubernetes_service[each.key].id
  log_analytics_workspace_id = data.terraform_remote_state.hub.outputs.log_analytics_workspace_id
}