resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  name                = var.settings.name # not supported by CAF
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
}

resource "azurerm_federated_identity_credential" "federated_identity_credential" {
  for_each = var.settings.federated_credentials == null ? {} : var.settings.federated_credentials

  name                = each.value.name # not supported by CAF
  resource_group_name = var.resource_group_name
  audience            = each.value.audience
  issuer              = each.value.issuer
  parent_id           = azurerm_user_assigned_identity.user_assigned_identity.id
  subject             = each.value.subject
}