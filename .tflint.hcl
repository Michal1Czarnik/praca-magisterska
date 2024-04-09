plugin "terraform" {
    enabled = true
    preset = "all"
}

plugin "azurerm" {
    enabled = true
    source = "github.com/terraform-linters/tflint-ruleset-azurerm"
    version = "0.26.0"
}