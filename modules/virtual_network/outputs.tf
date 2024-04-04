output "virtual_network_id" {
  description = "The Virtual Network ID"
  value       = azurerm_virtual_network.virtual_network.id
}

output "virtual_network_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.virtual_network.name
}

output "subnet_id" {
  description = "The subnet name:id map"
  value = zipmap(
    [for k, v in var.settings.subnet : k],
    [for k, v in var.settings.subnet : azurerm_subnet.subnet[k].id]
  )
}