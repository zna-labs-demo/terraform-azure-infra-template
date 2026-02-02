# =============================================================================
# Sentinel Policy Set Configuration
# =============================================================================
# This file defines which policies are active and their enforcement level.
#
# Enforcement Levels:
# - advisory:    Warn but allow (informational)
# - soft-mandatory: Fail but can be overridden by authorized users
# - hard-mandatory: Fail and cannot be overridden
# =============================================================================

# -----------------------------------------------------------------------------
# Policy: Allowed Locations
# -----------------------------------------------------------------------------
# Similar to Azure Policy but catches violations earlier in the pipeline.
# Set to soft-mandatory so it can be overridden for exceptions.
policy "allowed-locations" {
  source            = "./allowed-locations.sentinel"
  enforcement_level = "soft-mandatory"
}

# -----------------------------------------------------------------------------
# Policy: Required Tags
# -----------------------------------------------------------------------------
# Ensures all resources have governance tags.
# Set to soft-mandatory for flexibility during initial rollout.
policy "required-tags" {
  source            = "./required-tags.sentinel"
  enforcement_level = "soft-mandatory"
}

# -----------------------------------------------------------------------------
# Policy: Naming Conventions
# -----------------------------------------------------------------------------
# UNIQUE TO SENTINEL - Azure Policy cannot enforce naming!
# Set to advisory initially to identify violations without blocking.
policy "naming-conventions" {
  source            = "./naming-conventions.sentinel"
  enforcement_level = "advisory"
}

# -----------------------------------------------------------------------------
# Policy: Security Requirements
# -----------------------------------------------------------------------------
# Enforces security best practices (TLS, encryption, etc.)
# Set to hard-mandatory - no exceptions for security.
policy "security-requirements" {
  source            = "./security-requirements.sentinel"
  enforcement_level = "hard-mandatory"
}
