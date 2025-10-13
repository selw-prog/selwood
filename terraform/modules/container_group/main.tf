resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_group" "prod_container" {
  count               = var.container_count
  name                = "${var.container_group_name_prefix}-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.os_type
  ip_address_type     = "Public"
  dns_name_label      = "${var.container_group_name_prefix}-${count.index + 1}"

  container {
    name   = "${var.container_group_name_prefix}-container-${count.index + 1}"
    image  = var.container_image
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  dynamic "image_registry_credential" {
    for_each = var.dockerhub_username != "" && var.dockerhub_password != "" ? [1] : []
    content {
      server   = "docker.io"
      username = var.dockerhub_username
      password = var.dockerhub_password
    }
  }
  depends_on = [azurerm_resource_group.this]
}