variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Central US"
}

variable "container_image" {
  description = "Container image to deploy"
  type        = string
  default     = "nginx:latest"
}

variable "os_type" {
  description = "Operating system type for the container"
  type        = string
  default     = "Linux"
}

variable "container_count" {
  description = "Number of container groups to create"
  type        = number
  default     = 2
}

variable "container_group_name_prefix" {
  description = "Prefix for container group names"
  type        = string
  default     = "container-group"
}

variable "dockerhub_username" {
  description = "Docker Hub username"
  type        = string
  default     = ""
  sensitive   = true
}

variable "dockerhub_password" {
  description = "Docker Hub password or access token"
  type        = string
  default     = ""
  sensitive   = true
}