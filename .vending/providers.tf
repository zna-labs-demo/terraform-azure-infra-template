# =============================================================================
# Provider Configuration - Environment Vending
# =============================================================================

provider "tfe" {
  # Token provided via TFE_TOKEN environment variable
  # Set by central vending on the {app_id}-vending workspace
}
