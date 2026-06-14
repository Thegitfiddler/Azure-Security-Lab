output "workspace_id" {
  value = azurerm_log_analytics_workspace.main.id
}

output "workspace_name" {
  value = azurerm_log_analytics_workspace.main.name
}

output "sentinel_workspace_id" {
  value = azurerm_sentinel_log_analytics_workspace_onboarding.main.workspace_id
}