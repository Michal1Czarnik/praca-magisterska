module "resource_group" {
  source = "../modules/resource_group"

  for_each = var.resource_groups

  global_settings = local.global_settings
  settings        = each.value
}