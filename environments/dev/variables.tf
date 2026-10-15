variable "subscription_id" {
  description = "The Azure Subscription ID"
  type        = string
  default     = "cc6eb6b0-ec2f-4e39-9a40-37a2b2ea1ba8"
}

variable "environment" {
  description = "Environment name (e.g. dev, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
  default     = "Devyani-RG-dev"
}

variable "vnet_address_space" {
  description = "Address space for VNet"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "frontend_subnet_prefix" {
  description = "CIDR block for frontend subnet"
  type        = string
  default     = "10.10.1.0/24"
}

variable "backend_subnet_prefix" {
  description = "CIDR block for backend subnet"
  type        = string
  default     = "10.10.2.0/24"
}

variable "database_subnet_prefix" {
  description = "CIDR block for database subnet"
  type        = string
  default     = "10.10.3.0/24"
}

variable "bastion_subnet_prefix" {
  description = "CIDR block for AzureBastionSubnet (minimum /26)"
  type        = string
  default     = "10.10.4.0/26"
}

variable "bastion_sku" {
  description = "SKU for Azure Bastion (Basic or Standard)"
  type        = string
  default     = "Basic"
}

variable "frontend_vm_size" {
  description = "Size of Frontend Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "backend_vm_size" {
  description = "Size of Backend Virtual Machine"
  type        = string
  default     = "Standard_B1s"
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
  description = "PostgreSQL administrator password (leave blank to auto-generate secure password)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "db_sku_name" {
  description = "PostgreSQL SKU (e.g. B_Standard_B1ms)"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "db_storage_mb" {
  description = "PostgreSQL Storage in MB"
  type        = number
  default     = 32768
}

variable "tags" {
  description = "Tags to be assigned to all resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "Devyani"
    ManagedBy   = "Terraform"
    Owner       = "DevOps-Team"
  }
}
