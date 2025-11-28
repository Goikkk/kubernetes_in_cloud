terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.54"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "9eb5e723-105f-4b88-a99e-d3bdd66f3f4d"
}

