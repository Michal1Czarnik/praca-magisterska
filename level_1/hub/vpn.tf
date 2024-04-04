resource "random_uuid" "vpn_app_role" {
  count = var.vpn ? 1 : 0
}

resource "random_uuid" "vpn_api_permissions" {
  count = var.vpn ? 1 : 0
}

resource "azuread_application" "vpn" {
  count = var.vpn ? 1 : 0

  display_name     = "vpn"
  sign_in_audience = "AzureADMyOrg"

  app_role {
    allowed_member_types = ["User"]
    description          = "VPN users"
    display_name         = "VPN_User"
    enabled              = true
    id                   = random_uuid.vpn_app_role[0].result
    value                = "VPN_User"
  }

  api {
    known_client_applications = ["41b23e61-6c1e-4545-b367-cd054e0ed4b4"] # Azure VPN client ID

    oauth2_permission_scope {
      id                         = random_uuid.vpn_api_permissions[0].result
      value                      = "vpn"
      type                       = "Admin"
      admin_consent_description  = "Admin consent for the VPN users"
      admin_consent_display_name = "vpn"
      enabled                    = true
    }
  }

  feature_tags {
    hide       = true
    enterprise = true
  }
}

resource "azuread_application_pre_authorized" "vpn_pre_authorization" {
  count = var.vpn ? 1 : 0

  application_object_id = azuread_application.vpn[0].object_id
  authorized_app_id     = "41b23e61-6c1e-4545-b367-cd054e0ed4b4" # Azure VPN client ID

  permission_ids = [azuread_application.vpn[0].oauth2_permission_scope_ids["vpn"]]
}

resource "azuread_service_principal" "vpn" {
  count = var.vpn ? 1 : 0

  description                  = "vpn"
  application_id               = azuread_application.vpn[0].application_id
  app_role_assignment_required = true
}

resource "azuread_app_role_assignment" "vpn_access" {
  for_each = var.vpn ? var.vpn_groups : []

  app_role_id         = azuread_application.vpn[0].app_role_ids["VPN_User"]
  principal_object_id = data.terraform_remote_state.launchpad.outputs.ad_groups_id[each.value]
  resource_object_id  = azuread_service_principal.vpn[0].object_id
}

module "vpn" {
  source = "../../modules/virtual_network_gateway"

  count = var.vpn ? 1 : 0

  global_settings = data.terraform_remote_state.launchpad.outputs.global_settings

  subnets             = module.virtual_network["hub"].subnet_id
  resource_group_name = module.resource_group["networking"].name

  settings = {
    name               = "vpn"
    resource_group_key = "vpn"

    public_ip = {
      allocation_method = "Static"
      sku               = "Standard"
    }

    virtual_network_gateway = {
      type       = "Vpn"
      vpn_type   = "RouteBased"
      sku        = "VpnGw1"
      generation = "Generation1"

      ip_configuration = {
        private_ip_address_allocation = "Dynamic"
        subnet_key                    = "vpn_gateway"
      }

      vpn_client_configuration = {
        address_space        = ["192.168.0.0/27"]
        aad_tenant           = "https://login.microsoftonline.com/${data.azuread_client_config.current.tenant_id}"
        aad_audience         = azuread_application.vpn[0].application_id
        aad_issuer           = "https://sts.windows.net/${data.azuread_client_config.current.tenant_id}/"
        vpn_client_protocols = ["OpenVPN"]
        vpn_auth_types       = ["AAD"]
      }
    }
  }
}

# Do we need nva?