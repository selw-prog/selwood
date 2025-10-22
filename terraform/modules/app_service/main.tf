# Configure the Azure provider (inherited from the root module)
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create an App Service Plan
resource "azurerm_service_plan" "asp" {
  name                = "${var.app_service_name}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = var.os_type
  sku_name            = var.app_service_sku
}

# Create an App Service
resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id = azurerm_service_plan.asp.id

  # App settings for SQL database connection
  app_settings = {
    "DATABASE_URL" = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};User Id=${var.sql_admin_username};Password=${var.sql_admin_password};"
  }

  site_config {
    always_on        = var.always_on
    application_stack {
      python_version = var.runtime_stack == "PYTHON|3.9" ? "3.9" : var.runtime_stack == "PYTHON|3.8" ? "3.8" : null
    }
  }
}

# Create an Azure SQL Server
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

# Create a firewall rule to allow Azure services
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name                = "AllowAzureServices"
  server_id           = azurerm_mssql_server.sql_server.id
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

# Create a SQL Database
resource "azurerm_mssql_database" "db" {
  name                = var.sql_database_name
  server_id           = azurerm_mssql_server.sql_server.id
  sku_name            = var.sql_database_sku
  max_size_gb         = var.sql_database_max_size_gb
}