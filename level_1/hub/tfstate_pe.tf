module "private_endpoint" {
  source = "../../modules/private_endpoint"

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings
  settings = {
    name       = "petfstate"
    subnet_key = "hub"
    private_service_connection = {
      subresource_names = ["blob"]
    }
    private_dns_zone_group = {
      name                 = "private-dns-zone-goup"
      private_dns_zone_key = ["blob"]
    }
  }
  private_dns_zone_ids           = { for k, v in var.private_dns : k => module.private_dns[k].id }
  resource_group_name            = data.terraform_remote_state.launchpad.outputs.tfstate_rg_name
  subnets                        = module.virtual_network["hub"].subnet_id
  private_connection_resource_id = data.terraform_remote_state.launchpad.outputs.tfstate_id
}