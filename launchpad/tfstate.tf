# The storage account has to be deployed when VPN is in place
module "tfstate" {
  source = "../modules/storage_account"

  global_settings = local.global_settings

  resource_group_name = module.resource_group["tfstate"].name

  settings = {
    name                          = "tfstate"
    account_kind                  = "BlobStorage"
    account_tier                  = "Standard"
    account_replication_type      = "LRS"
    access_tier                   = "Hot"
    is_hns_enabled                = false
    public_network_access_enabled = true
    blob_properties = {
      versioning_enabled = true
    }
    network_rules = {
      default_action = "Deny"
      bypass         = ["AzureServices"]
    }
  }
}