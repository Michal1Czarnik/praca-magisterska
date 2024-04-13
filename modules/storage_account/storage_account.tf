resource "azurerm_storage_account" "storage_account" {
  name                = azurecaf_name.st.result
  resource_group_name = var.resource_group_name
  location            = coalesce(var.settings.location, var.global_settings.default_location)

  account_kind             = var.settings.account_kind
  account_tier             = var.settings.account_tier
  account_replication_type = "GRS"
  access_tier              = var.settings.access_tier

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false

  is_hns_enabled = var.settings.is_hns_enabled

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  dynamic "blob_properties" {
    for_each = var.settings.blob_properties == null ? [] : [var.settings.blob_properties]
    content {
      versioning_enabled  = blob_properties.value.versioning_enabled
      change_feed_enabled = blob_properties.value.change_feed_enabled
      dynamic "delete_retention_policy" {
        for_each = blob_properties.value.delete_retention_policy == null ? [] : [blob_properties.value.delete_retention_policy]
        content {
          days = delete_retention_policy.value.days
        }
      }
      dynamic "restore_policy" {
        for_each = blob_properties.value.restore_policy == null ? [] : [blob_properties.value.restore_policy]
        content {
          days = restore_policy.value.days
        }
      }
    }
  }
}

resource "time_sleep" "wait_90_seconds" {
  count = var.settings.storage_container == null ? 0 : 1

  depends_on = [module.private_endpoint]

  create_duration = "90s"
}

resource "azurerm_storage_container" "storage_container" {
  for_each = var.settings.storage_container == null ? [] : var.settings.storage_container

  name                 = azurecaf_name.stct[each.value].result
  storage_account_name = azurerm_storage_account.storage_account.name

  depends_on = [time_sleep.wait_90_seconds] # need to wait at least 90s to propagate the DNS entry 
}
