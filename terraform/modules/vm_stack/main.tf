provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "this" {
  name = "${var.name}-vnet"
  address_space = var.vnet_address_space
  location = var.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name = "${var.name}-subnet"
  resource_group_name = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes = var.subnet_address_prefixes
}

resource "azurerm_public_ip" "this" {
  name = "${var.name}-public-ip"
  location = var.location
  resource_group_name = azurerm_resource_group.this.name
  allocation_method = "Dynamic"
  sku = "Basic"
}

resource "azurerm_network_interface" "this" {
  name = "${var.name}-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.this.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.this.id
  }
}

resource "azurerm_network_interface_security_group_association" "this" {
  network_interface_id = azurerm_network_interface.this.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_linux_virtual_machine" "this" {
  name = var.name
  resource_group_name = azurerm_resource_group.this.name
  location = var.location
  size = var.vm_size
  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  admin_ssh_key {
    username = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer = "debian-11"
    sku = "11"
    version = "latest"
  }
}