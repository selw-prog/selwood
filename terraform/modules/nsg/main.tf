provider "azurerm" {
  features {}
}

resource "azurerm_network_security_group" "this" {
    name = var.nsg_name
    location = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name = "AllowSSH"
        priority = 100
        direction = "Inbound"
        access = "Allow"
        protocol = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = var.ssh_source_ip
        destination_address_prefix = "*"
    }
}
