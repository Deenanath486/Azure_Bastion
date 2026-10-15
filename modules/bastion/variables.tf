variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the bastion host will be created"
  type        = string
}

variable "bastion_name" {
  description = "Name of the Azure Bastion host"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Public IP for Azure Bastion"
  type        = string
}

variable "bastion_subnet_id" {
  description = "ID of the AzureBastionSubnet"
  type        = string
}

variable "sku" {
  description = "The SKU of the Bastion Host. Accepted values are Basic, Standard, Premium"
  type        = string
  default     = "Standard"
}

variable "tags" {
  description = "Tags to be applied to Bastion resources"
  type        = map(string)
  default     = {}
}
