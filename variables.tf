variable "name" {
  description = "Name of the Azure AI Foundry Project."
  type        = string
}

variable "location" {
  description = "Azure region for the project (typically same as hub)."
  type        = string
}

variable "ai_services_hub_id" {
  description = "Resource ID of the parent Azure AI Foundry hub."
  type        = string
}

variable "friendly_name" {
  description = "Optional display name for the project."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional description for the project."
  type        = string
  default     = null
}

variable "high_business_impact_enabled" {
  description = "Enable HBI mode (reduces diagnostics; forces new resource if changed)."
  type        = bool
  default     = null
}

variable "primary_user_assigned_identity" {
  description = "User-assigned identity ID used for encryption scenarios (optional)."
  type        = string
  default     = null
}

variable "identity" {
  description = <<-EOT
    Optional managed identity configuration.
    Examples:
      { type = "SystemAssigned" }
      { type = "UserAssigned", identity_ids = ["/subscriptions/.../resourceGroups/.../providers/Microsoft.ManagedIdentity/userAssignedIdentities/ua-mi"] }
      { type = "SystemAssigned, UserAssigned", identity_ids = ["..."] }
  EOT
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "tags" {
  description = "Optional tags to apply to the project."
  type        = map(string)
  default     = {}
}
