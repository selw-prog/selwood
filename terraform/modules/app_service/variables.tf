variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "Central US"
}

variable "app_service_name" {
  description = "Name of the App Service (must be globally unique)"
  type        = string
}

variable "os_type" {
  description = "Operating system for the App Service Plan (Linux or Windows)"
  type        = string
  default     = "Linux"
}

variable "app_service_sku" {
  description = "SKU for the App Service Plan (e.g., B1, S1, P1v2)"
  type        = string
  default     = "B1"
}

variable "runtime_stack" {
  description = "Runtime stack for the App Service (e.g., PYTHON|3.9, NODE|14)"
  type        = string
  default     = "PYTHON|3.9"
}

variable "always_on" {
  description = "Enable Always On for the App Service"
  type        = bool
  default     = true
}

variable "sql_server_name" {
  description = "Name of the SQL Server (must be globally unique)"
  type        = string
}

variable "sql_admin_username" {
  description = "SQL Server admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL Server admin password"
  type        = string
  sensitive   = true
}

variable "sql_database_name" {
  description = "Name of the SQL Database"
  type        = string
  default     = "myappdb"
}

variable "sql_database_sku" {
  description = "SKU for the SQL Database (e.g., Basic, S0, S1)"
  type        = string
  default     = "Basic"
}

variable "sql_database_max_size_gb" {
  description = "Maximum size of the SQL Database in GB"
  type        = number
  default     = 2
}