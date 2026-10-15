<<<<<<< HEAD
# Azure Bastion & PostgreSQL Flexible Server Architecture (Dev & Prod)
### Enterprise-Grade 3-Tier Multi-VM Architecture

Child and Parent modular Terraform structure deploying **Devyani-RG**, **VNet** with:
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
d:\Azure Bastion\
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
| **Subscription ID** | `cc6eb6b0-ec2f-4e39-9a40-37a2b2ea1ba8` | `cc6eb6b0-ec2f-4e39-9a40-37a2b2ea1ba8` |
| **VNet CIDR** | `10.10.0.0/16` | `10.20.0.0/16` |
| **Frontend VM** | `Standard_B1s` (Standard_LRS) | `Standard_D2s_v3` (Premium_LRS) |
| **Backend VM** | `Standard_B1s` (Standard_LRS) | `Standard_D2s_v3` (Premium_LRS) |
| **PostgreSQL DB** | `B_Standard_B1ms` (32 GB, Auto-grow) | `GP_Standard_D2s_v3` (64 GB, HA ZoneRedundant) |
| **Azure Bastion** | Basic SKU | Standard SKU |

---

## 🚀 Execution Guide (Plan Tak)

### 1. Dev Environment
```powershell
cd "d:\Azure Bastion\environments\dev"
terraform init
terraform validate
terraform plan
```

### 2. Prod Environment
```powershell
cd "d:\Azure Bastion\environments\prod"
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
=======
# Azure_Bastion
>>>>>>> origin/main
