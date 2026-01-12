# =============================================================================
# Terraform & Provider Versions - Environment Vending
# =============================================================================
# This terraform runs in the {app_id}-vending workspace and creates
# environment-specific workspaces based on environments.yaml
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  # Backend is configured dynamically via TF_WORKSPACE environment variable
  # Workspace name: {app_id}-vending

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.57"
    }
  }
}
