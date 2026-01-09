# Sample Change 4: Security Issues (tfsec will flag)
# Copy this content to demonstrate SecurityScan catching issues

# BAD - Storage account allows public blob access
resource "azurerm_storage_account" "insecure_storage" {
  name                     = "stinsecuredemo"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # SECURITY ISSUE: Public access enabled
  allow_nested_items_to_be_public = true

  # SECURITY ISSUE: HTTPS not enforced
  enable_https_traffic_only = false

  # SECURITY ISSUE: Minimum TLS version too low
  min_tls_version = "TLS1_0"
}

# BAD - Key Vault with no network restrictions
resource "azurerm_key_vault" "insecure_vault" {
  name                = "kv-insecure-demo"
  location            = var.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  # SECURITY ISSUE: No purge protection
  purge_protection_enabled = false

  # SECURITY ISSUE: Soft delete disabled
  soft_delete_retention_days = 7
}

# BAD - SQL Server with public access
resource "azurerm_mssql_server" "insecure_sql" {
  name                         = "sql-insecure-demo"
  resource_group_name          = azurerm_resource_group.example.name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd123!"  # SECURITY ISSUE: Hardcoded password

  # SECURITY ISSUE: Public network access enabled
  public_network_access_enabled = true
}

# Expected Result:
# - SecurityScan (tfsec) flags multiple issues:
#   - AVD-AZU-0012: Storage account public access
#   - AVD-AZU-0008: HTTPS not enforced
#   - AVD-AZU-0001: Minimum TLS version
#   - AVD-AZU-0013: Key Vault purge protection
#   - AVD-AZU-0020: Hardcoded credentials
# - Pipeline continues (continueOnError: true) but issues are reported
# - Discuss: Should security issues block deployment?
