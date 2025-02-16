# Resource Group variables ---------------------------------------------------
variable "rg-name" {
  type    = string
  default = "Project"
}

variable "location" {
  type    = string
  default = "east us"
}


# SQL Server variables ---------------------------------------------------
variable "sql-server-name" {
  type    = string
  default = "PROJECT-sql-server-tf"
}

variable "Sql-Server-version" {
  type    = string
  default = "12.0"
}


variable "sql-server-admin-name" {
  type    = string
  default = "Test"
}

variable "sql-server-admin-password" {
  type    = string
  default = "Complex@12345"
}

variable "minimum_tls_version" {
  type    = number
  default = 1.2
}


# Azure Active directory / Entra ID variables -----------------------------------------
variable "azuread_administrator" {
  type    = string
  default = "AZURE-GROUP-NAME"
}

variable "azuread_administrator-object_id" {
  type    = string
  default = "AZURE-administrator-object_id"
}


# SQL Database variables ---------------------------------------------------
variable "SQL-DB-Name" {
  type    = string
  default = "PROJECT-sql-Database-tf"
}

variable "collation" {
  type    = string
  default = "SQL_Latin1_General_CP1_CI_AS"
}


variable "license_type_included" {
  type    = string
  default = "LicenseIncluded"
}

variable "db-max-size" {
  type    = number
  default = 4
}


# SQL server Firewall variables ---------------------------------------------------
variable "Firewall-name" {
  type    = string
  default = "Test-User-L1-New"
}


variable "start_ip_address" {
  type    = string
  default = "<START-IP-RANGE>"
}


variable "end_ip_address" {
  type    = string
  default = "<END-IP-RANGE>"
}