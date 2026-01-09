# Sample Change 3: Validation Error (WILL FAIL)
# Copy this content to demonstrate TerraformValidate check failing

# BAD - References a variable that doesn't exist
resource "azurerm_resource_group" "demo_validation" {
  name     = "rg-${var.nonexistent_variable}"
  location = var.location
}

# BAD - Uses wrong resource type
resource "azurerm_fake_resource" "demo" {
  name = "fake"
}

# BAD - Missing required argument
resource "azurerm_storage_account" "incomplete" {
  name                = "stincomplete"
  # Missing: resource_group_name, location, account_tier, account_replication_type
}

# Expected Result:
# - TerraformValidate check FAILS
# - Error message shows which variable/resource is invalid
# - Fix by adding missing variables or correcting resource types
