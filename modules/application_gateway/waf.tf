resource "azurerm_web_application_firewall_policy" "waf_policy" {
  name                = azurecaf_name.wafp.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 10
    max_request_body_size_in_kb = 1024
  }
}