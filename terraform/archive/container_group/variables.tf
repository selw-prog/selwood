variable "resource_group_name" {
    description = "Name of the resource group for all resources"
    type = string
    default = "aci-stack"
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