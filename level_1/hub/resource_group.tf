module "resource_group" {
  source = "../../modules/resource_group"

  for_each = var.resource_groups

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings        = each.value
}