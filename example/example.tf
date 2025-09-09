
resource "azurerm_resource_group" "rg" {
  name     = "rg-ai-foundry-demo-001"
  location = "Southeast Asia"
}

resource "random_id" "sa" { byte_length = 4 }

resource "azurerm_storage_account" "hub_sa" {
  name                     = "aifndry${random_id.sa.hex}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
}

# ----------- Hub module (from your earlier module) -----------
module "ai_foundry_hub" {
  source              = "./modules/ai-foundry"
  name                = "aihub-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  storage_account_id  = azurerm_storage_account.hub_sa.id

  identity = { type = "SystemAssigned" }

  tags = { env = "demo" }
}

# ----------- Project module (this module) -----------
module "ai_foundry_project" {
  source             = "./modules/ai-foundry-project"
  name               = "aiproj-demo"
  location           = azurerm_resource_group.rg.location
  ai_services_hub_id = module.ai_foundry_hub.id

  friendly_name = "Demo Project"
  description   = "Project deployed via Terraform module"
  # Optional: HBI mode
  # high_business_impact_enabled = true

  identity = { type = "SystemAssigned" }

  tags = { env = "demo" }
}
