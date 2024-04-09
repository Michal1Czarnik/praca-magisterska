output "log_analytics_workspace_id" {
  value = module.logging.id
  description = "Log analytics ID"
}

output "vnet_hub_id" {
  value = module.virtual_network["hub"].virtual_network_id
  description = "HUB vnet ID"
}

output "vnet_hub_name" {
  value = module.virtual_network["hub"].virtual_network_name
  description = "HUB vnet name"
}

output "vnet_hub_rg" {
  value = module.resource_group["networking"].name
  description = "HUB vnet rg name"
}

output "private_dns_zone_ids" {
  value = { for k, v in var.private_dns : k => module.private_dns[k].id }
  description = "Priv dns zone ids"
}