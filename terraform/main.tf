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

module "vm_stack" {
  source = "./modules/vm_stack"
  resource_group_name = "elwood-website"
  location = "Central US"
  name = "debian-vm"
  vm_size = "Standard_B1ls"
  admin_username = "sean"
  admin_ssh_public_key = file("~/.ssh/id_rsa.pub")
}