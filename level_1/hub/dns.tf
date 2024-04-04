# DNS relay
module "dns_relay" {
  source = "../../modules/linux_virtual_machine"

  for_each = var.dns_relays

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = merge(
    each.value,
    {
      custom_data = base64encode(file("${path.module}/files/dns_relay_cloud_config.sh"))
      public_key  = file("${path.module}/files/id_rsa.pub")
    }
  )
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  subnets             = module.virtual_network[can(each.value.virtual_network_key) ? each.value.virtual_network_key : "hub"].subnet_id
}

# Pivate DNS
module "private_dns" {
  source = "../../modules/private_dns"

  for_each = var.private_dns

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = merge(
    each.value,
    { virtual_network_id = module.virtual_network[can(each.value.virtual_network_key) ? each.value.virtual_network_key : "hub"].virtual_network_id }
  )
  resource_group_name = module.resource_group[can(each.value.resource_group_key) ? each.value.resource_group_key : "networking"].name
}

resource "azurerm_dns_zone" "my_domains" {
  for_each = var.my_domains

  name                = each.value
  resource_group_name = module.resource_group["networking"].name
}
