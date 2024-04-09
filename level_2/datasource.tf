data "azurerm_subscription" "current" {}

data "terraform_remote_state" "launchpad" {
  backend = "local"

  config = {
    path = "${path.module}/../launchpad/terraform.tfstate"
  }
}

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "${path.module}/../level_1/hub/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke" {
  backend = "local"

  config = {
    path = "${path.module}/../level_1/spoke/terraform.tfstate"
  }
}
