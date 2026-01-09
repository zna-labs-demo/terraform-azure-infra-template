# Sample Change 2: Bad Formatting (WILL FAIL)
# Copy this content to demonstrate TerraformFormat check failing

# BAD - Inconsistent spacing and indentation
variable "demo_bad_format" {
description = "This has bad formatting"
    type = string
  default     =    "bad"
}

# BAD - Missing spaces around equals
resource "azurerm_resource_group" "demo"{
name     ="rg-demo"
  location="eastus"
tags={
environment="demo"
  }
}

# Expected Result:
# - TerraformFormat check FAILS
# - Pipeline stops, PR cannot be merged
# - Fix with: terraform fmt
