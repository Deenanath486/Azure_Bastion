# Generate unique random suffix to ensure globally unique resource names
resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

# Generate cryptographically secure database password (if not explicitly provided)
resource "random_password" "db_password" {
  length           = 20
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

# Generate secure password for Frontend & Backend VMs
resource "random_password" "vm_password" {
  length           = 18
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
}

# 1. Resource Group Module
module "resource_group" {
  source   = "../../modules/resource_group"
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# 2. Networking Module (VNet, Frontend, Backend, Database Subnets, AzureBastionSubnet & NSGs)
module "networking" {
  source                 = "../../modules/networking"
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  vnet_name              = "vnet-devyani-${var.environment}"
  vnet_address_space     = var.vnet_address_space
  frontend_subnet_name   = "snet-frontend-${var.environment}"
  frontend_subnet_prefix = var.frontend_subnet_prefix
  backend_subnet_name    = "snet-backend-${var.environment}"
  backend_subnet_prefix  = var.backend_subnet_prefix
  database_subnet_name   = "snet-database-${var.environment}"
  database_subnet_prefix = var.database_subnet_prefix
  bastion_subnet_prefix  = var.bastion_subnet_prefix
  tags                   = var.tags
}

# 3. Azure Bastion Module
module "bastion" {
  source              = "../../modules/bastion"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  bastion_name        = "bas-devyani-${var.environment}"
  public_ip_name      = "pip-bas-devyani-${var.environment}"
  bastion_subnet_id   = module.networking.bastion_subnet_id
  sku                 = var.bastion_sku
  tags                = var.tags
}

# 4. PostgreSQL Flexible Server PaaS Module (with Private DNS & VNet Link)
module "postgresql" {
  source                 = "../../modules/postgresql_flexible"
  resource_group_name    = module.resource_group.name
  location               = module.resource_group.location
  server_name            = "psql-devyani-${var.environment}-${random_string.suffix.result}"
  database_name          = "devyanidb_${var.environment}"
  postgres_version       = "16"
  delegated_subnet_id    = module.networking.database_subnet_id
  virtual_network_id     = module.networking.vnet_id
  private_dns_zone_name  = "devyani-${var.environment}-${random_string.suffix.result}.postgres.database.azure.com"
  admin_username         = var.db_admin_username
  admin_password         = var.db_admin_password != "" ? var.db_admin_password : random_password.db_password.result
  sku_name               = var.db_sku_name
  storage_mb             = var.db_storage_mb
  auto_grow_enabled      = true
  backup_retention_days  = 7
  high_availability_mode = null
  tags                   = var.tags
}

# 5. Backend Virtual Machine (Application Server with Python Flask & DB client)
module "backend_vm" {
  source              = "../../modules/compute"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vm_name             = "vm-backend-${var.environment}"
  subnet_id           = module.networking.backend_subnet_id
  vm_size             = var.backend_vm_size
  os_disk_type        = "Standard_LRS"
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password != "" ? var.vm_admin_password : random_password.vm_password.result
  tags                = var.tags
  custom_data         = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y python3 python3-pip python3-flask python3-psycopg2 postgresql-client

              cat << 'APP' > /opt/app.py
              from flask import Flask, jsonify
              app = Flask(__name__)

              @app.route('/')
              def home():
                  return jsonify({
                      "status": "online",
                      "environment": "${var.environment}",
                      "tier": "backend-api",
                      "message": "Devyani Backend API is running successfully!",
                      "db_fqdn": "${module.postgresql.fqdn}",
                      "database": "${module.postgresql.database_name}"
                  })

              @app.route('/health')
              def health():
                  return jsonify({"health": "ok"})

              if __name__ == '__main__':
                  app.run(host='0.0.0.0', port=5000)
              APP

              cat << 'SERVICE' > /etc/systemd/system/backend-api.service
              [Unit]
              Description=Devyani Backend API Service
              After=network.target

              [Service]
              User=root
              WorkingDirectory=/opt
              ExecStart=/usr/bin/python3 /opt/app.py
              Restart=always

              [Install]
              WantedBy=multi-user.target
              SERVICE

              systemctl daemon-reload
              systemctl enable backend-api
              systemctl start backend-api
              EOF
}

# 6. Frontend Virtual Machine (Nginx Web Server Reverse-Proxying to Backend)
module "frontend_vm" {
  source              = "../../modules/compute"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vm_name             = "vm-frontend-${var.environment}"
  subnet_id           = module.networking.frontend_subnet_id
  vm_size             = var.frontend_vm_size
  os_disk_type        = "Standard_LRS"
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password != "" ? var.vm_admin_password : random_password.vm_password.result
  tags                = var.tags
  custom_data         = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx

              cat << 'HTML' > /var/www/html/index.html
              <!DOCTYPE html>
              <html>
              <head>
                <title>Devyani - 3-Tier Architecture</title>
                <style>
                  body { font-family: Arial, sans-serif; background: #0f172a; color: #f8fafc; text-align: center; padding-top: 50px; }
                  .card { background: #1e293b; border-radius: 12px; padding: 30px; display: inline-block; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.3); }
                  h1 { color: #38bdf8; }
                  p { font-size: 18px; color: #94a3b8; }
                  .badge { background: #0284c7; padding: 6px 12px; border-radius: 6px; font-weight: bold; color: white; }
                </style>
              </head>
              <body>
                <div class="card">
                  <h1>Devyani Cloud Platform</h1>
                  <p>Environment: <span class="badge">${var.environment}</span></p>
                  <p>Tier 1: Frontend Web VM (Nginx)</p>
                  <p>Tier 2: Backend API VM (${module.backend_vm.private_ip_address}:5000)</p>
                  <p>Tier 3: PaaS PostgreSQL Flexible Server</p>
                  <p>Access Method: <strong>Azure Bastion (Private & Secure)</strong></p>
                </div>
              </body>
              </html>
              HTML

              systemctl enable nginx
              systemctl restart nginx
              EOF
}
