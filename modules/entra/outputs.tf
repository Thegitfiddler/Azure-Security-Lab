output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "resource_group_location" {
  value = azurerm_resource_group.main.location
}

output "security_admins_group_id" {
  value = azuread_group.security_admins.object_id
}

output "developers_group_id" {
  value = azuread_group.developers.object_id
}

output "soc_analysts_group_id" {
  value = azuread_group.soc_analysts.object_id
}