output "app_service_url" {
  description = "URL of the deployed App Service"
  value       = "https://${azurerm_linux_web_app.app.default_hostname}"
}

output "sql_server_fqdn" {
  description = "Fully qualified domain name of the SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_database_name" {
  description = "Name of the SQL Database"
  value       = azurerm_mssql_database.db.name
}