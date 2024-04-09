terraform {
  required_version = ">=1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = module.kubernetes_service["k8s01"].host
    client_certificate     = base64decode(module.kubernetes_service["k8s01"].client_certificate)
    client_key             = base64decode(module.kubernetes_service["k8s01"].client_key)
    cluster_ca_certificate = base64decode(module.kubernetes_service["k8s01"].cluster_ca_certificate)
  }
}