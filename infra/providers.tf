terraform {
  required_version = ">= 1.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = "dedc9660-0b2e-48a9-a2f5-3f3fdda7db11"
  resource_provider_registrations = "none"
}