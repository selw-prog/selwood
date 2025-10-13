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

module "container_group" {
  source                     = "./modules/container_group"
  resource_group_name        = var.resource_group_name
  dockerhub_username = var.dockerhub_username
  dockerhub_password = var.dockerhub_password
}