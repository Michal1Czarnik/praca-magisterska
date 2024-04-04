locals {
  global_settings = {
    prefixes         = [random_string.prefix.result]
    random_length    = 0
    clean_input      = true
    separator        = "-"
    passthrough      = false
    use_slug         = true
    default_location = "swedencentral"
  }
}