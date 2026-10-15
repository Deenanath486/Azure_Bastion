variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the PostgreSQL server will be deployed"
  type        = string
}

variable "server_name" {
  description = "The name of the PostgreSQL Flexible Server"
  type        = string
}

variable "database_name" {
  description = "The name of the default PostgreSQL database to create"
  type        = string
  default     = "devyanidb"
}

variable "postgres_version" {
  description = "PostgreSQL major version (e.g. 13, 14, 15, 16)"
  type        = string
  default     = "16"
}

variable "delegated_subnet_id" {
  description = "The ID of the subnet delegated to PostgreSQL Flexible Server"
  type        = string
}

variable "virtual_network_id" {
  description = "The ID of the virtual network to link the private DNS zone"
  type        = string
}

variable "private_dns_zone_name" {
  description = "Name of the Private DNS Zone (must end with .postgres.database.azure.com)"
  type        = string
}

variable "admin_username" {
  description = "Administrator username for PostgreSQL"
  type        = string
  default     = "devyaniadmin"
}

variable "admin_password" {
  description = "Administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU Name for the PostgreSQL Flexible Server (e.g., B_Standard_B1ms, GP_Standard_D2s_v3)"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Storage size in MB (minimum 32768 MB = 32 GB)"
  type        = number
  default     = 32768
}

variable "storage_tier" {
  description = "Storage tier (e.g., P4, P6, P10, etc.)"
  type        = string
  default     = "P4"
}

variable "auto_grow_enabled" {
  description = "Enable automatic storage expansion"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Backup retention days (7 to 35)"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = false
}

variable "zone" {
  description = "Preferred availability zone for PostgreSQL primary server"
  type        = string
  default     = "1"
}

variable "high_availability_mode" {
  description = "High availability mode (e.g., ZoneRedundant, SameZone, or null to disable)"
  type        = string
  default     = null
}

variable "standby_availability_zone" {
  description = "Standby availability zone when high availability is enabled"
  type        = string
  default     = null
}

variable "maintenance_window_day" {
  description = "Day of week for maintenance window (0 = Sunday)"
  type        = number
  default     = 0
}

variable "maintenance_window_hour" {
  description = "Hour for maintenance window (0-23 UTC)"
  type        = number
  default     = 2
}

variable "maintenance_window_minute" {
  description = "Minute for maintenance window (0-59)"
  type        = number
  default     = 0
}

variable "tags" {
  description = "Tags to be applied to PostgreSQL resources"
  type        = map(string)
  default     = {}
}
