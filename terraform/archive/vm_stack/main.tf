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

module "nsg" {
  source = "../../modules/nsg"
  nsg_name = "home-nsg"
  location = "Central US"
  resource_group_name = var.resource_group_name
  ssh_source_ip = "145.223.7.47/32"
}

module "vm_stack" {
  source = "../../modules/vm_stack"
  resource_group_name = var.resource_group_name
  location = "Central US"
  name = "debian-vm"
  vm_size = "Standard_B1ls"
  admin_username = "sean"
  admin_ssh_public_key = file("~/.ssh/id_rsa.pub")
  admin_ssh_private_key = file("~/.ssh/id_rsa")
  nsg_id = module.nsg.nsg_id
}