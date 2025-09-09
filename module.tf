

resource "azurerm_ai_foundry_project" "this" {
  name               = var.name
  location           = var.location
  ai_services_hub_id = var.ai_services_hub_id

  # Optional metadata
  friendly_name                 = var.friendly_name
  description                   = var.description
  high_business_impact_enabled  = var.high_business_impact_enabled
  primary_user_assigned_identity = var.primary_user_assigned_identity

  tags = var.tags

  # Dynamic identity block (SystemAssigned / UserAssigned / both)
  dynamic "identity" {
    for_each = var.identity == null ? [] : [var.identity]
    content {
      type         = identity.value.type
      identity_ids = try(identity.value.identity_ids, [])
    }
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
