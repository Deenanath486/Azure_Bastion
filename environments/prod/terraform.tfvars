subscription_id          = "cc6eb6b0-ec2f-4e39-9a40-37a2b2ea1ba8"
environment               = "prod"
location                  = "centralindia"
resource_group_name       = "Devyani-RG-prod"
vnet_address_space        = ["10.20.0.0/16"]
frontend_subnet_prefix    = "10.20.1.0/24"
backend_subnet_prefix     = "10.20.2.0/24"
database_subnet_prefix    = "10.20.3.0/24"
bastion_subnet_prefix     = "10.20.4.0/26"
bastion_sku               = "Standard"
db_admin_username         = "devyaniadmin"
# Leave empty to automatically generate a secure 24-character password
db_admin_password         = ""
db_sku_name               = "GP_Standard_D2s_v3"
db_storage_mb             = 65536
high_availability_mode    = "ZoneRedundant"
zone                      = "1"
standby_availability_zone = "2"

tags = {
  Environment = "prod"
  Project     = "Devyani"
  ManagedBy   = "Terraform"
  Owner       = "DevOps-Team"
}
