# Azure Bastion & PostgreSQL Flexible Server Architecture (Dev & Prod)
### Enterprise-Grade 3-Tier Multi-VM Architecture

[![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/Microsoft_Azure-0078D4?style=flat&logo=microsoft-azure&logoColor=white)](https://azure.microsoft.com/)
[![Architecture](https://img.shields.io/badge/Architecture-3--Tier%20VNet-success?style=flat)](https://github.com/Deenanath486/Azure_Bastion)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Child and Parent modular Terraform structure deploying **Resource Group**, **VNet** with:
- **Frontend Subnet** + **Frontend Linux VM** (Nginx Web Server)
- **Backend Subnet** + **Backend Linux VM** (Application Server + PostgreSQL Client)
- **Database Subnet** + **PostgreSQL Flexible Server** (PaaS Service with Private DNS)
- **AzureBastionSubnet** + **Azure Bastion Host** (Secure Browser-based SSH to private VMs without public IPs)

---

## 🏗️ 3-Tier Architecture Diagram

```text
[ Internet User ]
       │
       ▼ (HTTPS :443 / HTTP :80)
┌──────────────────────────────────────────────────────────────┐
│ Virtual Network (vnet-devyani)                                │
│                                                              │
│  ┌─────────────────────────┐                                 │
│  │ Frontend Subnet         │                                 │
│  │ ┌─────────────────────┐ │                                 │
│  │ │ vm-frontend (Nginx) │ │                                 │
│  │ └──────────┬──────────┘ │                                 │
│  └────────────┼────────────┘                                 │
│               │ (App Traffic)                                │
│  ┌────────────▼────────────┐     ┌────────────────────────┐  │
│  │ Backend Subnet          │     │ AzureBastionSubnet     │  │
│  │ ┌─────────────────────┐ │     │ ┌────────────────────┐ │  │
│  │ │ vm-backend (App/API)│◄┼─────┼─┤ bas-devyani Host   │ │  │
│  │ └──────────┬──────────┘ │ SSH │ └─────────▲──────────┘ │  │
│  └────────────┼────────────┘     └───────────┼────────────┘  │
│               │ (Port 5432)                  │ (HTTPS :443)  │
│  ┌────────────▼────────────┐                 │               │
│  │ Database Subnet         │        [ DevOps Engineer ]      │
│  │ ┌─────────────────────┐ │        (Secure Browser SSH)     │
│  │ │ PostgreSQL PaaS     │ │                                 │
│  │ └─────────────────────┘ │                                 │
│  └─────────────────────────┘                                 │
└──────────────────────────────────────────────────────────────┘
```

---

## 📁 Directory Structure

```text
.
├── .gitignore                             # Ignores local state, secrets, and caches
├── modules/                               # Reusable Child Modules
│   ├── resource_group/                    # Azure Resource Group
│   ├── networking/                        # VNet, Frontend, Backend, DB & Bastion Subnets + 4 NSGs
│   ├── compute/                           # Linux VM + NIC + OS Disk + Cloud-Init
│   ├── bastion/                           # Azure Bastion Host + Standard Public IP
│   └── postgresql_flexible/               # PaaS PostgreSQL Flexible Server + Private DNS & Auto-grow
└── environments/                          # Parent Environment Modules
    ├── dev/                               # Cost-optimized Dev (Standard_B1s VMs, Burstable DB)
    │   ├── providers.tf
    │   ├── variables.tf
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── terraform.tfvars
    └── prod/                              # Production (Standard_D2s_v3 VMs, HA ZoneRedundant DB)
        ├── providers.tf
        ├── variables.tf
        ├── main.tf
        ├── outputs.tf
        └── terraform.tfvars
```

---

## 🌐 Network & Compute Sizing

| Component | Dev Environment | Prod Environment |
| :--- | :--- | :--- |
| **Subscription ID** | `<your-azure-subscription-id>` | `<your-azure-subscription-id>` |
| **VNet CIDR** | `10.10.0.0/16` | `10.20.0.0/16` |
| **Frontend VM** | `Standard_B1s` (Standard_LRS) | `Standard_D2s_v3` (Premium_LRS) |
| **Backend VM** | `Standard_B1s` (Standard_LRS) | `Standard_D2s_v3` (Premium_LRS) |
| **PostgreSQL DB** | `B_Standard_B1ms` (32 GB, Auto-grow) | `GP_Standard_D2s_v3` (64 GB, HA ZoneRedundant) |
| **Azure Bastion** | Basic SKU | Standard SKU |

---

## 🚀 Execution Guide (Plan Tak)

### 1. Dev Environment
```powershell
cd environments/dev
terraform init
terraform validate
terraform plan
```

### 2. Prod Environment
```powershell
cd environments/prod
terraform init
terraform validate
terraform plan
```

### 3. Password Fetch (After Apply)
```powershell
# VM Password:
terraform output -raw vm_admin_password

# Database Password:
terraform output -raw postgresql_admin_password
```
