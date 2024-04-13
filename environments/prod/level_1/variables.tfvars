resource_groups = {
  networking = {
    name = "networking-spoke-prod"
  }
  common = {
    name = "common-prod"
  }
}

virtual_networks = {
  spoke = {
    name               = "spoke-prod"
    resource_group_key = "networking"
    address_space      = "10.0.16.0/20"
    dns_servers        = ["10.0.7.245"]
    subnet = {
      spoke = {
        name             = "spoke-prod"
        address_prefixes = ["10.0.16.0/22"]
      }
      postgresql_delegated = {
        name              = "postgresql_delegated"
        address_prefixes  = ["10.0.23.240/28"]
        service_endpoints = ["Microsoft.KeyVault", "Microsoft.Sql", "Microsoft.Storage"]
        delegation = {
          name         = "postgresql"
          service_name = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions      = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
        }
      }
      appgw = {
        name             = "ApplicationGatewaySubnet"
        address_prefixes = ["10.0.23.128/26"]
      }
    }
  }
}

network_security_groups = {
  common = {
    name               = "common-prod"
    resource_group_key = "networking"
    network_security_rule = {
      inbound_allow_from_hub = {
        name                       = "AllowFromHub"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.0.0/20"
        destination_address_prefix = "*"
      }
      # inbound_allow_from_Internet_to_load_balancer = {
      #   name                       = "AllowFromInternetToLB"
      #   priority                   = 110
      #   direction                  = "Inbound"
      #   access                     = "Allow"
      #   protocol                   = "Tcp"
      #   source_port_range          = "*"
      #   destination_port_ranges     = ["80", "443"]
      #   source_address_prefix      = "Internet"
      #   destination_address_prefix = "20.23.195.143" # IP address of azure load balancer for k8s cluster
      # }
    }
  }
}

subnet_network_security_group_associations = {
  common_common = {
    virtual_network_key        = "spoke"
    subnet_key                 = "spoke"
    network_security_group_key = "common"
  }
}

key_vaults = {
  common = {
    name                       = "common-prod"
    resource_group_key         = "common"
    sku_name                   = "standard"
    soft_delete_retention_days = 7
    rbac_permissions = {
      "developers" = "Key Vault Administrator"
    }
    private_endpoint = {
      name       = "pekvcommonprod"
      subnet_key = "spoke"
      private_service_connection = {
        subresource_names = ["vault"]
      }
      private_dns_zone_group = {
        name                 = "private-dns-zone-goup"
        private_dns_zone_key = ["vault"]
      }
    }
  }
}

route_tables = {
  default = {
    name               = "default-prod"
    resource_group_key = "networking"
    route = [{
      name                   = "default"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.0.7.132"
    }]
  }
}

route_table_associations = {
  spoke = {
    virtual_network_key = "spoke"
    subnet_key          = "spoke"
    route_table_key     = "default"
  }
}