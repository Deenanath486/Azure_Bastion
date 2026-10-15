output "server_id" {
  description = "The ID of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.server.id
}

output "server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.server.name
}

output "fqdn" {
  description = "The fully qualified domain name of the PostgreSQL Flexible Server"
  value       = azurerm_postgresql_flexible_server.server.fqdn
}

output "database_id" {
  description = "The ID of the created database"
  value       = azurerm_postgresql_flexible_server_database.database.id
}

output "database_name" {
  description = "The name of the created database"
  value       = azurerm_postgresql_flexible_server_database.database.name
}

output "admin_username" {
  description = "The administrator username for PostgreSQL"
  value       = azurerm_postgresql_flexible_server.server.administrator_login
}

output "private_dns_zone_id" {
  description = "The ID of the PostgreSQL Private DNS Zone"
  value       = azurerm_private_dns_zone.psql_dns.id
}
