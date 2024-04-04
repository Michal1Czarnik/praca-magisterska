data "azuread_client_config" "current" {}

data "terraform_remote_state" "launchpad" {
  backend = "local"

  config = {
    path = "${path.module}/../../launchpad/terraform.tfstate"
  }
}