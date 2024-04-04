terraform {
  required_version = ">=1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.75.0"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "1.2.26"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.41.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "prefix" {
  length  = 4
  special = false
  upper   = false
  numeric = false
}