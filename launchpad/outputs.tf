output "global_settings" {
  value = local.global_settings
}

output "tfstate_id" {
  value = module.tfstate.id
}

output "tfstate_rg_name" {
  value = module.resource_group["tfstate"].name
}

output "ad_groups_id" {
  value = try({ for k, v in azuread_group.group : k => v.object_id }, {})
}

output "ad_users_id" {
  value = try({ for k, v in data.azuread_user.user : k => v.object_id }, {})
}

output "managed_identities" {
  value = try({ for k, v in var.managed_identities : k => module.managed_identity[k] }, {})
}