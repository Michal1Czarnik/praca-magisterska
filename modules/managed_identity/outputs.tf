output "managed_identity" {
  description = "The object of attributes to export"
  value       = azurerm_user_assigned_identity.user_assigned_identity
}