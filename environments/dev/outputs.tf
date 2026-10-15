output "resource_group_name" {
  description = "Resource Group Name"
  value       = module.resource_group.name
}

output "vnet_name" {
  description = "Virtual Network Name"
  value       = module.networking.vnet_name
}

output "frontend_subnet_id" {
  description = "Frontend Subnet ID"
  value       = module.networking.frontend_subnet_id
}

output "backend_subnet_id" {
  description = "Backend Subnet ID"
  value       = module.networking.backend_subnet_id
}

output "database_subnet_id" {
  description = "Database Subnet ID"
  value       = module.networking.database_subnet_id
}

output "bastion_subnet_id" {
  description = "Azure Bastion Subnet ID"
  value       = module.networking.bastion_subnet_id
}

output "bastion_host_name" {
  description = "Azure Bastion Host Name"
  value       = module.bastion.bastion_host_name
}

output "bastion_dns_name" {
  description = "Azure Bastion DNS Name"
  value       = module.bastion.bastion_dns_name
}

output "bastion_public_ip" {
  description = "Azure Bastion Public IP"
  value       = module.bastion.bastion_public_ip
}

# Virtual Machine Outputs
output "frontend_vm_name" {
  description = "Frontend Virtual Machine Name"
  value       = module.frontend_vm.vm_name
}

output "frontend_vm_private_ip" {
  description = "Frontend VM Private IP (accessible securely via Bastion)"
  value       = module.frontend_vm.private_ip_address
}

output "backend_vm_name" {
  description = "Backend Virtual Machine Name"
  value       = module.backend_vm.vm_name
}

output "backend_vm_private_ip" {
  description = "Backend VM Private IP (accessible securely via Bastion)"
  value       = module.backend_vm.private_ip_address
}

output "vm_admin_username" {
  description = "Virtual Machine Administrator Username"
  value       = var.vm_admin_username
}

output "vm_admin_password" {
  description = "Virtual Machine Administrator Password"
  value       = var.vm_admin_password != "" ? var.vm_admin_password : random_password.vm_password.result
  sensitive   = true
}

# PostgreSQL Database Outputs
output "postgresql_server_name" {
  description = "PostgreSQL Flexible Server Name"
  value       = module.postgresql.server_name
}

output "postgresql_fqdn" {
  description = "PostgreSQL Flexible Server Private FQDN"
  value       = module.postgresql.fqdn
}

output "postgresql_database_name" {
  description = "PostgreSQL Database Name"
  value       = module.postgresql.database_name
}

output "postgresql_admin_username" {
  description = "PostgreSQL Administrator Username"
  value       = module.postgresql.admin_username
}

output "postgresql_admin_password" {
  description = "PostgreSQL Administrator Password (Auto-generated or provided)"
  value       = var.db_admin_password != "" ? var.db_admin_password : random_password.db_password.result
  sensitive   = true
}
