resource_groups = {
  tfstate = {
    name = "tfstate"
  }
  managed_identity = {
    name = "managed_identities"
  }
}

managed_identities = {
  aks_pool = {
    name = "aks_pool"
  }

  aks_kubelet = {
    name = "aks_kubelet"
  }
}

ad_users = ["michal.czarnik"]

ad_groups = ["developers"]

ad_group_members = {
  dev-michal_czarnik = {
    user       = "michal.czarnik"
    group_name = "developers"
  }
}