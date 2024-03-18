terraform {
  backend "local" {}
  required_version = "1.5.4"
  required_providers {
    external = {
      source = "hashicorp/external"
      version = "2.3.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.49.0"
    }
  }
}