# Resource Group for the entire lab
resource "azurerm_resource_group" "main" {
  name     = "rg-${var.project}-${var.environment}"
  location = var.location
  tags     = var.tags
}

# Entra ID Users
resource "azuread_user" "security_admin" {
  user_principal_name = "sec-admin@${var.tenant_domain}"
  display_name        = "Security Admin"
  mail_nickname       = "sec-admin"
  password            = var.lab_user_password
  force_password_change = false
}

resource "azuread_user" "developer" {
  user_principal_name = "developer@${var.tenant_domain}"
  display_name        = "Lab Developer"
  mail_nickname       = "developer"
  password            = var.lab_user_password
  force_password_change = false
}

resource "azuread_user" "soc_analyst" {
  user_principal_name = "soc-analyst@${var.tenant_domain}"
  display_name        = "SOC Analyst"
  mail_nickname       = "soc-analyst"
  password            = var.lab_user_password
  force_password_change = false
}

# Security Groups
resource "azuread_group" "security_admins" {
  display_name     = "Security Admins"
  security_enabled = true
  members = [
    azuread_user.security_admin.object_id
  ]
}

resource "azuread_group" "developers" {
  display_name     = "Developers"
  security_enabled = true
  members = [
    azuread_user.developer.object_id
  ]
}

resource "azuread_group" "soc_analysts" {
  display_name     = "SOC Analysts"
  security_enabled = true
  members = [
    azuread_user.soc_analyst.object_id
  ]
}