output "log_analytics_workspace_id" {
  value = module.logging.id
}

output "vnet_hub_id" {
  value = module.virtual_network["hub"].virtual_network_id
}

output "vnet_hub_name" {
  value = module.virtual_network["hub"].virtual_network_name
}

output "vnet_hub_rg" {
  value = module.resource_group["networking"].name
}

output "private_dns_zone_ids" {
  value = { for k, v in var.private_dns : k => module.private_dns[k].id }
}