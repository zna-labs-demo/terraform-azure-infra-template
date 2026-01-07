# =============================================================================
# Outputs
# =============================================================================
# Export key information about the provisioned infrastructure.
# These outputs are visible in Terraform Cloud and can be used by other systems.
# =============================================================================

output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_id" {
  description = "Azure Resource ID of the resource group"
  value       = azurerm_resource_group.main.id
}

output "location" {
  description = "Azure region where resources are deployed"
  value       = azurerm_resource_group.main.location
}

output "app_id" {
  description = "Application identifier"
  value       = var.app_id
}

output "environment" {
  description = "Deployment environment"
  value       = var.environment
}

# -----------------------------------------------------------------------------
# Optional Resource Outputs
# -----------------------------------------------------------------------------

output "storage_account_name" {
  description = "Name of the storage account (if enabled)"
  value       = var.enable_storage_account ? azurerm_storage_account.main[0].name : null
}

output "storage_account_primary_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = var.enable_storage_account ? azurerm_storage_account.main[0].primary_blob_endpoint : null
}

output "key_vault_name" {
  description = "Name of the Key Vault (if enabled)"
  value       = var.enable_key_vault ? azurerm_key_vault.main[0].name : null
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = var.enable_key_vault ? azurerm_key_vault.main[0].vault_uri : null
}
