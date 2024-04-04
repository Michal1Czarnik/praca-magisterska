data "azuread_client_config" "current" {}

data "terraform_remote_state" "launchpad" {
  backend = "local"

  config = {
    path = "${path.module}/../../launchpad/terraform.tfstate"
  }
}

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "${path.module}/../hub/terraform.tfstate"
  }
}

