subscription_id        = "cc6eb6b0-ec2f-4e39-9a40-37a2b2ea1ba8"
environment            = "dev"
location               = "centralindia"
resource_group_name    = "Devyani-RG-dev"
vnet_address_space     = ["10.10.0.0/16"]
frontend_subnet_prefix = "10.10.1.0/24"
backend_subnet_prefix  = "10.10.2.0/24"
database_subnet_prefix = "10.10.3.0/24"
bastion_subnet_prefix  = "10.10.4.0/26"
bastion_sku            = "Basic"
db_admin_username      = "devyaniadmin"
# Leave empty to automatically generate a secure 20-character password
db_admin_password = ""
db_sku_name       = "B_Standard_B1ms"
db_storage_mb     = 32768

tags = {
  Environment = "dev"
  Project     = "Devyani"
  ManagedBy   = "Terraform"
  Owner       = "DevOps-Team"
}
