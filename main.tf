# =============================================================================
# Main Infrastructure Configuration
# =============================================================================
# This is your starting point for Azure infrastructure.
# The resource group is created by default. Enable additional resources
# by setting the feature flag variables to true.
# =============================================================================

# -----------------------------------------------------------------------------
# Resource Group (Always Created)
# -----------------------------------------------------------------------------
resource "azurerm_resource_group" "main" {
  name     = local.resource_names.resource_group
  location = var.location
  tags     = local.common_tags
}

# -----------------------------------------------------------------------------
# Storage Account (Optional)
# -----------------------------------------------------------------------------
resource "azurerm_storage_account" "main" {
  count = var.enable_storage_account ? 1 : 0

  name                     = local.resource_names.storage_account
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
  }

  tags = local.common_tags
}

# -----------------------------------------------------------------------------
# Key Vault (Optional)
# -----------------------------------------------------------------------------
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "main" {
  count = var.enable_key_vault ? 1 : 0

  name                = local.resource_names.key_vault
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = local.common_tags
}

# =============================================================================
# NEXT STEPS - Add Your Infrastructure Here
# =============================================================================
# Examples of resources you might add:
#
# 1. Virtual Network:
#    resource "azurerm_virtual_network" "main" { ... }
#
# 2. App Service:
#    resource "azurerm_service_plan" "main" { ... }
#    resource "azurerm_linux_web_app" "main" { ... }
#
# 3. Azure SQL Database:
#    resource "azurerm_mssql_server" "main" { ... }
#    resource "azurerm_mssql_database" "main" { ... }
#
# See the README.md for more guidance on extending this template.
# =============================================================================
