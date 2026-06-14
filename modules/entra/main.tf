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
# Get current subscription data
data "azurerm_subscription" "current" {}

# Security Admin - Security Reader at subscription level
resource "azurerm_role_assignment" "security_admin_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Security Reader"
  principal_id         = azuread_group.security_admins.object_id
}

# Security Admin - Security Admin at resource group level
resource "azurerm_role_assignment" "security_admin_rg" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Security Admin"
  principal_id         = azuread_group.security_admins.object_id
}

# Developer - Contributor at resource group level only
resource "azurerm_role_assignment" "developer_contributor" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Contributor"
  principal_id         = azuread_group.developers.object_id
}

# SOC Analyst - Security Reader at subscription level
resource "azurerm_role_assignment" "soc_analyst_reader" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Security Reader"
  principal_id         = azuread_group.soc_analysts.object_id
}

# SOC Analyst - Log Analytics Reader
resource "azurerm_role_assignment" "soc_analyst_logs" {
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Log Analytics Reader"
  principal_id         = azuread_group.soc_analysts.object_id
}