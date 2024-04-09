output "global_settings" {
  value = local.global_settings
  description = "Global settings"
}

output "tfstate_id" {
  value = module.tfstate.id
  description = "Tfstate ID"
}

output "tfstate_rg_name" {
  value = module.resource_group["tfstate"].name
  description = "Tfstate rg name"
}

output "ad_groups_id" {
  value = try({ for k, v in azuread_group.group : k => v.object_id }, {})
  description = "AD groups"
}

output "ad_users_id" {
  value = try({ for k, v in data.azuread_user.user : k => v.object_id }, {})
  description = "AD users"
}

output "managed_identities" {
  value = try({ for k, v in var.managed_identities : k => module.managed_identity[k] }, {})
  description = "Managed IDs"
}