# =============================================================================
# Input Variables
# =============================================================================
# Standard variables for infrastructure deployment.
# app_id is automatically populated by the subscription vending process.
# =============================================================================

variable "app_id" {
  description = "Application identifier from subscription vending (e.g., a2026010501)"
  type        = string

  validation {
    condition     = can(regex("^a[0-9]+$", var.app_id))
    error_message = "app_id must start with 'a' followed by numbers (e.g., a2026010501)."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "test", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, test, staging, prod."
  }
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# =============================================================================
# Feature Flags
# =============================================================================
# Use these to enable/disable optional infrastructure components

variable "enable_storage_account" {
  description = "Create a storage account for the application"
  type        = bool
  default     = false
}

variable "enable_key_vault" {
  description = "Create a Key Vault for secrets management"
  type        = bool
  default     = false
}
