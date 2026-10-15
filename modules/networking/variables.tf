variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the network will be created"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "frontend_subnet_name" {
  description = "Name of the frontend subnet"
  type        = string
  default     = "frontend-subnet"
}

variable "frontend_subnet_prefix" {
  description = "Address prefix for the frontend subnet"
  type        = string
}

variable "backend_subnet_name" {
  description = "Name of the backend subnet"
  type        = string
  default     = "backend-subnet"
}

variable "backend_subnet_prefix" {
  description = "Address prefix for the backend subnet"
  type        = string
}

variable "database_subnet_name" {
  description = "Name of the database subnet"
  type        = string
  default     = "database-subnet"
}

variable "database_subnet_prefix" {
  description = "Address prefix for the database subnet"
  type        = string
}

variable "bastion_subnet_prefix" {
  description = "Address prefix for AzureBastionSubnet (minimum /26)"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to networking resources"
  type        = map(string)
  default     = {}
}
