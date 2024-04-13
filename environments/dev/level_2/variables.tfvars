resource_groups = {
  app = {
    name = "app-dev"
  }
}

postgresql_servers = {
  psql01 = {
    name                  = "psql01-dev"
    resource_group_key    = "app"
    version               = "15"
    sku_name              = "B_Standard_B1ms" # CPU: 1; RAM: 2GB
    storage_mb            = 32768
    auto_grow_enabled     = true
    backup_retention_days = 7
    databases             = ["app"]
  }
}

kubernetes_services = {
  k8s01 = {
    name                      = "k8s-dev"
    resource_group_key        = "app"
    sku_tier                  = "Free"
    kubernetes_version        = "1.27"
    private_cluster_enabled   = true
    oidc_issuer_enabled       = true
    workload_identity_enabled = true
    nginx_ingress_enabled     = true
    nginx_private_ip          = "10.0.32.132"
    default_node_pool = {
      name                         = "default"
      vm_size                      = "Standard_B2ms"
      enable_node_public_ip        = false
      enable_auto_scaling          = false
      only_critical_addons_enabled = false
      os_disk_size_gb              = 128
      vnet_subnet_key              = "spoke"
      temporary_name_for_rotation  = "temprotation"
      type                         = "VirtualMachineScaleSets"
      node_count                   = 2
    }
    network_profile = {
      network_plugin = "azure"
      network_policy = "calico"
      outbound_type  = "userDefinedRouting"
      service_cidr   = "10.0.36.0/23"
      dns_service_ip = "10.0.36.10"
    }
  }
}