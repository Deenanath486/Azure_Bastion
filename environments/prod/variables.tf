variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
  default     = "cc6eb6b0-ec2f-4e39-9a40-37a2b2ea1ba8"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
  default     = "prod"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
  default     = "Devyani-RG-prod"
}

variable "vnet_address_space" {
  description = "Address space for VNet"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "frontend_subnet_prefix" {
  description = "CIDR block for frontend subnet"
  type        = string
  default     = "10.20.1.0/24"
}

variable "backend_subnet_prefix" {
  description = "CIDR block for backend subnet"
  type        = string
  default     = "10.20.2.0/24"
}

variable "database_subnet_prefix" {
  description = "CIDR block for database subnet"
  type        = string
  default     = "10.20.3.0/24"
}

variable "bastion_subnet_prefix" {
  description = "CIDR block for AzureBastionSubnet (minimum /26)"
  type        = string
  default     = "10.20.4.0/26"
}

variable "bastion_sku" {
  description = "SKU for Azure Bastion (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "frontend_vm_size" {
  description = "Size of Frontend Virtual Machine in Prod"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "backend_vm_size" {
  description = "Size of Backend Virtual Machine in Prod"
  type        = string
  default     = "Standard_D2s_v3"
}

variable "vm_admin_username" {
  description = "Administrator username for VMs"
  type        = string
  default     = "devyaniadmin"
}

variable "vm_admin_password" {
  description = "Administrator password for VMs (leave blank to auto-generate)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_admin_username" {
  description = "PostgreSQL administrator username"
  type        = string
  default     = "devyaniadmin"
}

variable "db_admin_password" {
  description = "PostgreSQL administrator password (leave blank to auto-generate secure 24-char password)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_sku_name" {
  description = "PostgreSQL SKU (e.g. GP_Standard_D2s_v3)"
  type        = string
  default     = "GP_Standard_D2s_v3"
}

variable "db_storage_mb" {
  description = "PostgreSQL Storage in MB"
  type        = number
  default     = 65536
}

variable "high_availability_mode" {
  description = "High availability mode (e.g., ZoneRedundant, SameZone, or null to disable)"
  type        = string
  default     = "ZoneRedundant"
}

variable "zone" {
  description = "Primary availability zone"
  type        = string
  default     = "1"
}

variable "standby_availability_zone" {
  description = "Standby availability zone"
  type        = string
  default     = "2"
}

variable "tags" {
  description = "Tags to be assigned to all resources"
  type        = map(string)
  default = {
    Environment = "prod"
    Project     = "Devyani"
    ManagedBy   = "Terraform"
    Owner       = "DevOps-Team"
  }
}
