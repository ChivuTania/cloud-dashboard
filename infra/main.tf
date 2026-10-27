resource "azurerm_resource_group" "dashboard" {
  name     = "clouddash-prod-weu-rg"
  location = "westeurope"
}

resource "azurerm_log_analytics_workspace" "dashboard" {
  name                = "clouddash-prod-weu-log"
  location            = azurerm_resource_group.dashboard.location
  resource_group_name = azurerm_resource_group.dashboard.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}