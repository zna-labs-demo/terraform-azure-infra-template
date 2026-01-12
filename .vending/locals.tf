# =============================================================================
# Local Values - Environment Vending
# =============================================================================
# Parses environments.yaml and prepares data structures for workspace creation
# =============================================================================

locals {
  # ---------------------------------------------------------------------------
  # Load and parse environment configuration
  # ---------------------------------------------------------------------------
  config = yamldecode(file("${path.module}/../environments.yaml"))

  # ---------------------------------------------------------------------------
  # Filter to only enabled environments
  # ---------------------------------------------------------------------------
  enabled_environments = {
    for env in local.config.environments :
    env.name => env
    if env.enabled == true
  }

  # ---------------------------------------------------------------------------
  # Generate workspace configurations
  # ---------------------------------------------------------------------------
  workspace_configs = {
    for name, env in local.enabled_environments :
    name => {
      # Workspace name: {app_id}{tier}1{env_code}{sequence}
      # Example: a2026011201n1d01 (dev), a2026011201n1q01 (qa), a2026011201p1p01 (prod)
      workspace_name   = "${var.app_id}${env.tier}1${env.environment_code}${env.sequence}"
      environment_name = env.name
      tier             = env.tier
      environment_code = env.environment_code
      sequence         = env.sequence
      auto_apply       = env.auto_apply

      # Calculate subnet CIDRs from app's VNet CIDR
      # App VNet: 10.X.0.0/16
      # Dev subnets: 10.X.0.0/24, 10.X.1.0/24, 10.X.2.0/26
      # QA subnets:  10.X.10.0/24, 10.X.11.0/24, 10.X.12.0/26
      # Prod subnets: 10.X.20.0/24, 10.X.21.0/24, 10.X.22.0/26
      subnet_offset = env.name == "dev" ? 0 : (env.name == "qa" ? 10 : 20)
    }
  }
}
