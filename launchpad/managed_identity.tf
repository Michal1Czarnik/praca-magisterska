module "managed_identity" {
  source = "../modules/managed_identity"

  for_each = var.managed_identities

  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = module.resource_group["managed_identity"].name
}