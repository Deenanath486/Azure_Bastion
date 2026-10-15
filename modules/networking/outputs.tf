output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.vnet.name
}

output "frontend_subnet_id" {
  description = "The ID of the frontend subnet"
  value       = azurerm_subnet.frontend.id
}

output "backend_subnet_id" {
  description = "The ID of the backend subnet"
  value       = azurerm_subnet.backend.id
}

output "database_subnet_id" {
  description = "The ID of the database subnet"
  value       = azurerm_subnet.database.id
}

output "bastion_subnet_id" {
  description = "The ID of the Azure Bastion subnet"
  value       = azurerm_subnet.bastion.id
}
