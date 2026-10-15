output "bastion_host_id" {
  description = "The ID of the Azure Bastion Host"
  value       = azurerm_bastion_host.bastion.id
}

output "bastion_host_name" {
  description = "The name of the Azure Bastion Host"
  value       = azurerm_bastion_host.bastion.name
}

output "bastion_dns_name" {
  description = "The fully qualified domain name of the Bastion host"
  value       = azurerm_bastion_host.bastion.dns_name
}

output "bastion_public_ip" {
  description = "The Public IP address allocated to Azure Bastion"
  value       = azurerm_public_ip.bastion_pip.ip_address
}
