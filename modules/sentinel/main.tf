# Log Analytics Workspace — the data store behind Sentinel
resource "azurerm_log_analytics_workspace" "main" {
  name                = "law-${var.project}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# Enable Microsoft Sentinel on the workspace
resource "azurerm_sentinel_log_analytics_workspace_onboarding" "main" {
  workspace_id = azurerm_log_analytics_workspace.main.id
}

# Azure Activity Logs — tracks all control plane operations in your subscription
resource "azurerm_log_analytics_solution" "activity" {
  solution_name         = "AzureActivity"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/AzureActivity"
  }
}

# Security Events solution
resource "azurerm_log_analytics_solution" "security" {
  solution_name         = "Security"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.main.id
  workspace_name        = azurerm_log_analytics_workspace.main.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Security"
  }
}

# Sentinel Analytics Rule — detect multiple failed logins (brute force)
resource "azurerm_sentinel_alert_rule_scheduled" "brute_force" {
  name                       = "detect-brute-force-login"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id
  display_name               = "Brute Force Login Attempt Detected"
  severity                   = "High"
  enabled                    = true
  query_frequency            = "PT5M"
  query_period               = "PT1H"

  query = <<-KQL
    SigninLogs
    | where ResultType != "0"
    | summarize FailedAttempts = count() by UserPrincipalName, IPAddress, bin(TimeGenerated, 5m)
    | where FailedAttempts >= 5
    | project TimeGenerated, UserPrincipalName, IPAddress, FailedAttempts
  KQL

  trigger_operator  = "GreaterThan"
  trigger_threshold = 0

  tactics = ["CredentialAccess"]
}

# Sentinel Analytics Rule — detect impossible travel
resource "azurerm_sentinel_alert_rule_scheduled" "impossible_travel" {
  name                       = "detect-impossible-travel"
  log_analytics_workspace_id = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id
  display_name               = "Impossible Travel Detected"
  severity                   = "Medium"
  enabled                    = true
  query_frequency            = "PT1H"
  query_period               = "PT24H"

  query = <<-KQL
    SigninLogs
    | where ResultType == "0"
    | project TimeGenerated, UserPrincipalName, Location, IPAddress
    | sort by UserPrincipalName, TimeGenerated asc
    | extend PrevLocation = prev(Location), PrevTime = prev(TimeGenerated), PrevUser = prev(UserPrincipalName)
    | where UserPrincipalName == PrevUser
    | where Location != PrevLocation
    | where datetime_diff('minute', TimeGenerated, PrevTime) < 60
    | project TimeGenerated, UserPrincipalName, Location, PrevLocation, IPAddress
  KQL

  trigger_operator  = "GreaterThan"
}