
# Create resource Group -------------------------------------------------------------------
resource "azurerm_resource_group" "Project" {
  name     = var.rg-name
  location = var.location
}



# Creates SQL Server -------------------------------------------------------------------
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


# Creates SQL Database -------------------------------------------------------------------
resource "azurerm_mssql_database" "PROJECT-Sql-DB-TF" {
  name           = var.SQL-DB-Name
  server_id      = azurerm_mssql_server.PROJECT-Sql-Server-TF.id
  license_type   = var.license_type_included
  zone_redundant = false
}



# Creates SQL Server > Network > Firewall Rule to allow access to Server --------------------------
resource "azurerm_mssql_firewall_rule" "Firewall1" {
  name             = var.Firewall-name
  server_id        = azurerm_mssql_database.PROJECT-Sql-DB-TF.id
  start_ip_address = var.start_ip_address
  end_ip_address   = var.end_ip_address
}


# END --------------------------------------------------------------------------------------------