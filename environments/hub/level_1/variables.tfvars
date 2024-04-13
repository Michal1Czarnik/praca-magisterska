resource_groups = {
  networking = {
    name = "networking-hub"
  }
  logging = {
    name = "logging"
  }
}

virtual_networks = {
  hub = {
    name               = "hub"
    resource_group_key = "networking"
    address_space      = "10.0.0.0/20"
    dns_servers        = ["10.0.7.245"]
    subnet = {
      dns = {
        name             = "dns"
        address_prefixes = ["10.0.7.240/28"]
      }
      hub = {
        name             = "hub"
        address_prefixes = ["10.0.0.0/22"]
      }
      vpn_gateway = {
        name             = "GatewaySubnet"
        caf_passthrough  = true
        address_prefixes = ["10.0.7.192/27"]
      }
      firewall = {
        name             = "AzureFirewallSubnet"
        caf_passthrough  = true
        address_prefixes = ["10.0.7.128/26"]
      }
    }
  }
}

network_security_groups = {
  common = {
    name               = "common"
    resource_group_key = "networking"
    network_security_rule = {
      inbound_allow_from_prod = {
        name                       = "AllowFromProd"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.16.0/20"
        destination_address_prefix = "*"
      }
      inbound_allow_from_dev = {
        name                       = "AllowFromDev"
        priority                   = 101
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.32.0/20"
        destination_address_prefix = "*"
      }
    }
  }
}

subnet_network_security_group_associations = {
  dns_common = {
    virtual_network_key        = "hub"
    subnet_key                 = "dns"
    network_security_group_key = "common"
  }
  common_common = {
    virtual_network_key        = "hub"
    subnet_key                 = "hub"
    network_security_group_key = "common"
  }
}

dns_relays = {
  relay_01 = {
    name               = "dns_relay_01"
    resource_group_key = "networking"
    subnet_key         = "dns"
    private_ip_address = "10.0.7.245"
    size               = "Standard_B1s"
    dns_servers        = ["168.63.129.16"]
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
}

private_dns = {
  blob = {
    name = "privatelink.blob.core.windows.net"
  }
  vault = {
    name = "privatelink.vaultcore.azure.net"
  }
  postgres = {
    name = "privatelink.postgres.database.azure.com"
  }
  aks = {
    name = "privatelink.swedencentral.azmk8s.io"
  }
  dummy_domain = {
    name = "mydummydomain.pl"
  }
}

logging = {
  name               = "logging"
  resource_group_key = "logging"
  daily_quota_gb     = 1
}

vpn        = true
vpn_groups = ["developers"]

firewall = {
  name               = "firewall01"
  resource_group_key = "networking"
  public_ip = {
    allocation_method = "Static"
    sku               = "Standard"
  }
  firewall = {
    subnet_key = "firewall"
    sku_name   = "AZFW_VNet"
    sku_tier   = "Standard" # "Basic" 
  }
  # network_rule_collections = {
  #   shared = {
  #     name = "nrcshared"
  #     priority = 100
  #     action = "Allow"
  #     rule = {
  #       ntp = {
  #         source_addresses      = ["10.0.0.0/16"]
  #         destination_ports     = ["123"]
  #         destination_addresses = ["*"]
  #         protocols             = ["Any"]
  #       }
  #       dns = {
  #         source_addresses      = ["10.0.0.0/16"]
  #         destination_ports     = ["53"]
  #         destination_addresses = ["*"]
  #         protocols             = ["Any"]
  #       }
  #       acr = {
  #         source_addresses      = ["10.0.0.0/16"]
  #         destination_ports     = ["*"]
  #         destination_addresses = ["AzureContainerRegistry"]
  #         protocols             = ["Any"]
  #       }
  #       mcr = {
  #         source_addresses      = ["10.0.0.0/16"]
  #         destination_ports     = ["*"]
  #         destination_addresses = ["MicrosoftContainerRegistry"]
  #         protocols             = ["Any"]
  #       }
  #       aad = {
  #         source_addresses      = ["10.0.0.0/16"]
  #         destination_ports     = ["*"]
  #         destination_addresses = ["AzureActiveDirectory"]
  #         protocols             = ["Any"]
  #       }
  #       amo = {
  #         source_addresses      = ["10.0.0.0/16"]
  #         destination_ports     = ["*"]
  #         destination_addresses = ["AzureMonitor"]
  #         protocols             = ["Any"]
  #       }
  #     }
  #   }
  # }
  application_rule_collections = {
    shared = {
      name     = "arcshared"
      priority = 100
      action   = "Allow"
      rule = {
        azure = {
          source_addresses = ["10.0.0.0/16"]
          target_fqdns     = ["*.blob.storage.azure.net", "*.mcr.microsoft.com", "mcr.microsoft.com", "packages.microsoft.com", "gallery.azure.com", "go.microsoft.com", "management.core.windows.net", "management.azure.com", "login.microsoftonline.com", "login-p.microsoftonline.com", "graph.windows.net", "azure.microsoft.com", "www.microsoft.com", "*.servicebus.windows.net", "*.database.windows.net", "*.core.windows.net", "*.documents.azure.com", "*.batch.azure.com", "*.vault.azure.net", "*.azure-api.net", "*.guestconfiguration.azure.com"]
          protocol = {
            http = {
              port = 80
              type = "Http"
            }
            https = {
              port = 443
              type = "Https"
            }
          }
        }
        k8s = {
          source_addresses = ["10.0.0.0/16"]
          target_fqdns     = ["*.ubuntu.com", "pkgs.k8s.io", "100.100.100.200", "registry.k8s.io", "*.pkg.dev", "*.amazonaws.com"]
          protocol = {
            http = {
              port = 80
              type = "Http"
            }
            https = {
              port = 443
              type = "Https"
            }
          }
        }
        st = {
          source_addresses = ["10.0.0.0/16"]
          target_fqdns     = ["AzureKubernetesService"]
          protocol = {
            http = {
              port = 80
              type = "Http"
            }
            https = {
              port = 443
              type = "Https"
            }
          }
        }
        dockerhub = {
          source_addresses = ["10.0.0.0/16"]
          target_fqdns     = ["*.docker.io", "*.docker.com", "docker.io", "docker.com"]
          protocol = {
            http = {
              port = 80
              type = "Http"
            }
            https = {
              port = 443
              type = "Https"
            }
          }
        }
      }
    }
  }
}

my_domains = ["mydummydomain.pl"]

route_tables = {
  default = {
    name               = "default"
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
  hub = {
    virtual_network_key = "hub"
    subnet_key          = "hub"
    route_table_key     = "default"
  }
}

