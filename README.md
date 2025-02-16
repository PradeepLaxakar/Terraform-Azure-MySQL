# Terraform Azure SQL Module

## Overview
This Terraform module provisions the following Azure resources:

- **Resource Group**
- **SQL Server**
- **SQL Database**
- **SQL Server Firewall Rule**
- **Azure AD Administrator**

## Directory Structure
```
terraform-azure-sql/
│── main.tf
│── provider.tf
│── terraform.tfstate
│── terraform.tfstate.backup
│── variable.tf
```

## Terraform Resources

### 1. Resource Group
Creates an Azure Resource Group for organizing resources.

```hcl
resource "azurerm_resource_group" "Project" {
  name     = var.rg-name
  location = var.location
}
```

### 2. SQL Server
Creates an Azure SQL Server with administrator authentication and optional Azure AD integration.

```hcl
resource "azurerm_mssql_server" "PROJECT-Sql-Server-TF" {
  name                         = var.sql-server-name
  resource_group_name          = azurerm_resource_group.Project.name
  location                     = azurerm_resource_group.Project.location
  version                      = var.Sql-Server-version
  administrator_login          = var.sql-server-admin-name
  administrator_login_password = var.sql-server-admin-password
  minimum_tls_version          = var.minimum_tls_version

  azuread_administrator {
    login_username = var.azuread_administrator
    object_id      = var.azuread_administrator-object_id
  }
}
```

### 3. SQL Database
Creates an Azure SQL Database within the SQL Server.

```hcl
resource "azurerm_mssql_database" "PROJECT-Sql-DB-TF" {
  name           = var.SQL-DB-Name
  server_id      = azurerm_mssql_server.PROJECT-Sql-Server-TF.id
  license_type   = var.license_type_included
  zone_redundant = false
}
```

### 4. Firewall Rule
Configures a firewall rule to allow access to the SQL Server.

```hcl
resource "azurerm_mssql_firewall_rule" "Firewall1" {
  name             = var.Firewall-name
  server_id        = azurerm_mssql_server.PROJECT-Sql-Server-TF.id
  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
}
```

### 5. Azure AD Administrator
Assigns an Azure Active Directory administrator for SQL Server authentication.

```hcl
resource "azurerm_mssql_server" "PROJECT-Sql-Server-TF" {
  azuread_administrator {
    login_username = var.azuread_administrator
    object_id      = var.azuread_administrator-object_id
  }
}
```

## Prerequisites
- Terraform installed ([Download Terraform](https://www.terraform.io/downloads.html))
- Azure CLI installed ([Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli))
- Azure subscription and necessary permissions

## Usage
1. Initialize Terraform:
   ```sh
   terraform init
   ```
2. Plan the deployment:
   ```sh
   terraform plan
   ```
3. Apply the configuration:
   ```sh
   terraform apply -auto-approve
   ```
4. To destroy resources:
   ```sh
   terraform destroy -auto-approve
   ```

## Variables
Ensure that you define the necessary variables in `variable.tf`. Example:

```hcl
variable "rg-name" {}
variable "location" {}
variable "sql-server-name" {}
variable "Sql-Server-version" {}
variable "sql-server-admin-name" {}
variable "sql-server-admin-password" {}
variable "minimum_tls_version" {}
variable "azuread_administrator" {}
variable "azuread_administrator-object_id" {}
variable "SQL-DB-Name" {}
variable "license_type_included" {}
variable "Firewall-name" {}
variable "start_ip_address" {}
variable "end_ip_address" {}
```

## Outputs
You can define outputs as needed, such as:

```hcl
output "sql_server_name" {
  value = azurerm_mssql_server.PROJECT-Sql-Server-TF.name
}
```

