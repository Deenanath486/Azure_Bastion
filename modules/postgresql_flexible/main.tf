# Private DNS Zone for PostgreSQL Flexible Server
resource "azurerm_private_dns_zone" "psql_dns" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Link Private DNS Zone to the Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "psql_dns_link" {
  name                  = "${var.server_name}-dns-link"
  private_dns_zone_name = azurerm_private_dns_zone.psql_dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
  tags                  = var.tags
}

# Azure Database for PostgreSQL Flexible Server (PaaS)
resource "azurerm_postgresql_flexible_server" "server" {
  name                   = var.server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.postgres_version
  delegated_subnet_id    = var.delegated_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.psql_dns.id
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  zone                   = var.zone

  storage_mb        = var.storage_mb
  storage_tier      = var.storage_tier
  auto_grow_enabled = var.auto_grow_enabled
  sku_name          = var.sku_name

  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  dynamic "high_availability" {
    for_each = var.high_availability_mode != null ? [var.high_availability_mode] : []
    content {
      mode                      = high_availability.value
      standby_availability_zone = var.standby_availability_zone
    }
  }

  maintenance_window {
    day_of_week  = var.maintenance_window_day
    start_hour   = var.maintenance_window_hour
    start_minute = var.maintenance_window_minute
  }

  tags = var.tags

  depends_on = [
    azurerm_private_dns_zone_virtual_network_link.psql_dns_link
  ]

  lifecycle {
    ignore_changes = [
      zone,
      high_availability[0].standby_availability_zone
    ]
  }
}

# Initial Application Database
resource "azurerm_postgresql_flexible_server_database" "database" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.server.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}
