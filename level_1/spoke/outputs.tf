output "spoke_subnets" {
  value = module.virtual_network["spoke"].subnet_id
  description = "spoke subnets"
}

output "key_vault_id" {
  value = { for k, v in var.key_vaults : k => module.key_vault[k].id }
  description = "Key vault key ID"
}