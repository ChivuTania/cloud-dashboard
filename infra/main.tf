resource "azurerm_resource_group" "dashboard" {
  name     = "clouddash-prod-weu-rg"
  location = "westeurope"

  tags = {
    managed_by = "terraform"
  }
}

resource "azurerm_log_analytics_workspace" "dashboard" {
  name                = "clouddash-prod-weu-log"
  location            = azurerm_resource_group.dashboard.location
  resource_group_name = azurerm_resource_group.dashboard.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_container_registry" "dashboard" {
  name                = "clouddashprodweuacr"
  resource_group_name = azurerm_resource_group.dashboard.name
  location            = azurerm_resource_group.dashboard.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_user_assigned_identity" "dashboard" {
  name                = "clouddash-prod-weu-id"
  resource_group_name = azurerm_resource_group.dashboard.name
  location            = azurerm_resource_group.dashboard.location
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_container_registry.dashboard.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.dashboard.principal_id
}

resource "azurerm_container_app_environment" "dashboard" {
  name                       = "clouddash-prod-weu-cae"
  location                   = azurerm_resource_group.dashboard.location
  resource_group_name        = azurerm_resource_group.dashboard.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.dashboard.id
}

resource "azurerm_container_app" "dashboard" {
  name                         = "clouddash-prod-weu-ca"
  resource_group_name          = azurerm_resource_group.dashboard.name
  container_app_environment_id = azurerm_container_app_environment.dashboard.id
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.dashboard.id]
  }

  registry {
    server   = azurerm_container_registry.dashboard.login_server
    identity = azurerm_user_assigned_identity.dashboard.id
  }

  ingress {
    external_enabled = true
    target_port      = 8000

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    min_replicas = 0
    max_replicas = 1

    container {
      name   = "dashboard"
      image  = "${azurerm_container_registry.dashboard.login_server}/cloud-dashboard:v0.3.0"
      cpu    = 0.5
      memory = "1Gi"
    }
  }

  depends_on = [azurerm_role_assignment.acr_pull]

}