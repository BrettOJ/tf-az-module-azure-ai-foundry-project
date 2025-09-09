output "id" {
  description = "Resource ID of the Azure AI Foundry Project."
  value       = azurerm_ai_foundry_project.this.id
}

output "name" {
  description = "Project name."
  value       = azurerm_ai_foundry_project.this.name
}

output "project_id" {
  description = "Immutable project ID associated with this Azure AI Foundry Project."
  value       = azurerm_ai_foundry_project.this.project_id
}

output "ai_services_hub_id" {
  description = "ID of the parent Azure AI Foundry hub."
  value       = azurerm_ai_foundry_project.this.ai_services_hub_id
}

output "identity_type" {
  description = "Type of managed identity configured on the Project (if any)."
  value       = try(azurerm_ai_foundry_project.this.identity[0].type, null)
}
