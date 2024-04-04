output "fw_private_ip" {
  description = "The Private IP address of the Azure Firewall"
  value       = azurerm_firewall.firewall.ip_configuration.0.private_ip_address
}

output "id" {
  value = azurerm_firewall.firewall.id
}