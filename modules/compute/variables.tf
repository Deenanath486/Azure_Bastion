variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region where the VM will be deployed"
  type        = string
}

variable "vm_name" {
  description = "Name of the Virtual Machine"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the VM NIC will be attached"
  type        = string
}

variable "vm_size" {
  description = "Size / SKU of the Virtual Machine"
  type        = string
  default     = "Standard_B1s"
}

variable "os_disk_type" {
  description = "Storage account type for OS Disk"
  type        = string
  default     = "Standard_LRS"
}

variable "admin_username" {
  description = "Administrator username for the VM"
  type        = string
  default     = "devyaniadmin"
}

variable "admin_password" {
  description = "Administrator password for the VM"
  type        = string
  sensitive   = true
}

variable "custom_data" {
  description = "Optional cloud-init script or startup script"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to be applied to VM resources"
  type        = map(string)
  default     = {}
}
