terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-weu-rg"
    storage_account_name = "tfstateweuclouddashboard"
    container_name       = "tfstate"
    key                  = "clouddash-prod.tfstate"
  }
}