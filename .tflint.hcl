# =============================================================================
# TFLint Configuration
# =============================================================================
# Static analysis rules for Terraform code quality.
# https://github.com/terraform-linters/tflint
# =============================================================================

config {
  # Enable module inspection
  call_module_type = "local"
  force            = false
}

# -----------------------------------------------------------------------------
# Azure Provider Plugin
# -----------------------------------------------------------------------------
plugin "azurerm" {
  enabled = true
  version = "0.25.1"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

# -----------------------------------------------------------------------------
# Terraform Language Rules
# -----------------------------------------------------------------------------

# Disallow deprecated syntax
rule "terraform_deprecated_interpolation" {
  enabled = true
}

# Ensure all variables have descriptions
rule "terraform_documented_variables" {
  enabled = true
}

# Ensure all outputs have descriptions
rule "terraform_documented_outputs" {
  enabled = true
}

# Enforce naming conventions
rule "terraform_naming_convention" {
  enabled = true

  variable {
    format = "snake_case"
  }

  locals {
    format = "snake_case"
  }

  output {
    format = "snake_case"
  }

  resource {
    format = "snake_case"
  }

  data {
    format = "snake_case"
  }
}

# Warn about unused declarations
rule "terraform_unused_declarations" {
  enabled = true
}

# Ensure terraform required version is set
rule "terraform_required_version" {
  enabled = true
}

# Ensure required providers are set
rule "terraform_required_providers" {
  enabled = true
}

# Use standard file structure
rule "terraform_standard_module_structure" {
  enabled = true
}
