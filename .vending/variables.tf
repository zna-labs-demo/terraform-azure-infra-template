# =============================================================================
# Input Variables - Environment Vending
# =============================================================================
# These variables are set by central vending on the {app_id}-vending workspace
# via TF_VAR_* environment variables.
#
# NOTE: Azure credentials are NOT passed through. Environment workspaces
# receive Azure OIDC configuration via a TFC Variable Set attachment.
# =============================================================================

variable "tfc_org" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "app_id" {
  description = "Application ID (e.g., a2026011201)"
  type        = string
}

variable "owner_email" {
  description = "Application owner email"
  type        = string
}

variable "cost_center" {
  description = "Cost center code"
  type        = string
}

variable "vnet_cidr" {
  description = "Allocated VNet CIDR block for this application"
  type        = string
}

# -----------------------------------------------------------------------------
# Azure OIDC Variable Set
# -----------------------------------------------------------------------------
# Instead of passing Azure credentials through, we attach a Variable Set
# that contains the OIDC configuration. This is more secure and centralized.
# -----------------------------------------------------------------------------
variable "azure_oidc_variable_set_id" {
  description = "TFC Variable Set ID containing Azure OIDC credentials"
  type        = string
}
