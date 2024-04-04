resource "random_password" "password" {
  length      = 32
  min_lower   = 5
  min_numeric = 5
  min_special = 5
  min_upper   = 5
}

resource "azurerm_key_vault_secret" "key_vault_secret" {
  name         = format("%s-password", var.settings.name)
  value        = random_password.password.result
  key_vault_id = var.key_vault_id
  content_type = "password"
}