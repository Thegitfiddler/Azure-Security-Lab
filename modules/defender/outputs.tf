output "cis_policy_assignment_id" {
  value = azurerm_subscription_policy_assignment.cis_benchmark.id
}

output "nist_policy_assignment_id" {
  value = azurerm_subscription_policy_assignment.nist.id
}