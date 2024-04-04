resource "azurerm_role_assignment" "aks_pool_dns_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = module.managed_identity["aks_pool"].managed_identity.principal_id
}

resource "azurerm_role_assignment" "aks_kubelet_mi_operator" {
  scope                = module.managed_identity["aks_kubelet"].managed_identity.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = module.managed_identity["aks_pool"].managed_identity.principal_id
}

resource "azurerm_role_assignment" "aks_kubelet_network_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Network Contributor"
  principal_id         = module.managed_identity["aks_pool"].managed_identity.principal_id
}