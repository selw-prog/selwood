terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

module "app_service" {
    source = "./modules/app_service"
    resource_group_name = "elwood_rg_app_service"
    app_service_name = "elwood-oct2025-app-service"
    sql_server_name = "elwood-oct2025-sql-server"
    sql_admin_username = var.sql_admin_username
    sql_admin_password = var.sql_admin_password
    runtime_stack = "PYTHON|3.9"
}