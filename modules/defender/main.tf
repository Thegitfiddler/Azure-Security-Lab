# Enable Defender for Cloud on key resource types
resource "azurerm_security_center_subscription_pricing" "defender_servers" {
  tier          = "Standard"
  resource_type = "VirtualMachines"
}

resource "azurerm_security_center_subscription_pricing" "defender_storage" {
  tier          = "Standard"
  resource_type = "StorageAccounts"
}

resource "azurerm_security_center_subscription_pricing" "defender_containers" {
  tier          = "Standard"
  resource_type = "Containers"
}

resource "azurerm_security_center_subscription_pricing" "defender_keyvault" {
  tier          = "Standard"
  resource_type = "KeyVaults"
}

resource "azurerm_security_center_subscription_pricing" "defender_arm" {
  tier          = "Standard"
  resource_type = "Arm"
}

# Set Log Analytics workspace for Defender for Cloud
resource "azurerm_security_center_workspace" "main" {
  scope        = "/subscriptions/${var.subscription_id}"
  workspace_id = var.workspace_id
}

# Defender for Cloud contact for alerts
resource "azurerm_security_center_contact" "main" {
  email               = var.security_contact_email
  alert_notifications = true
  alerts_to_admins    = true
}

# CIS Microsoft Azure Foundations Benchmark policy assignment
resource "azurerm_subscription_policy_assignment" "cis_benchmark" {
  name                 = "cis-azure-benchmark"
  display_name         = "CIS Microsoft Azure Foundations Benchmark"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/1a5bb27d-173f-493e-9568-eb56638dde4d"
  subscription_id      = "/subscriptions/${var.subscription_id}"

  identity {
    type = "SystemAssigned"
  }

  location = var.location
}

# NIST SP 800-53 policy assignment
resource "azurerm_subscription_policy_assignment" "nist" {
  name                 = "nist-sp-800-53"
  display_name         = "NIST SP 800-53 Rev. 5"
  policy_definition_id = "/providers/Microsoft.Authorization/policySetDefinitions/179d1daa-458f-4e47-8086-2a68d0d6c38f"
  subscription_id      = "/subscriptions/${var.subscription_id}"

  identity {
    type = "SystemAssigned"
  }

  location = var.location
}