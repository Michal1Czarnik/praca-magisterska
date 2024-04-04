data "azurerm_subscription" "current" {}

data "azuread_user" "user" {
  for_each = var.ad_users

  user_principal_name = format("%s@czarnik33gmail.onmicrosoft.com", each.value)
}