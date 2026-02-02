# Policy as Code: Azure Policy vs Terraform Sentinel

This directory contains example Sentinel policies demonstrating how Terraform Cloud Sentinel complements Azure Policy for comprehensive governance.

## Quick Comparison

| Aspect | Azure Policy | Terraform Sentinel |
|--------|-------------|-------------------|
| **When it runs** | At Azure API level | During TFC plan phase |
| **Blocks at** | After `terraform apply` starts | Before `terraform apply` |
| **Feedback speed** | Slower (waits for Azure API) | Faster (plan phase) |
| **Scope** | Azure resources only | Any Terraform provider |
| **Override** | Exemptions in Azure | Soft-mandatory policies |
| **Best for** | Runtime enforcement, Portal/CLI | Shift-left, CI/CD pipelines |

## Demo Scenario

### Scenario 1: Location Restriction (Both Can Do)

**Azure Policy:**
```
User runs: terraform apply
→ Terraform sends request to Azure API
→ Azure Policy evaluates the request
→ DENIED: "RequestDisallowedByPolicy"
→ User sees error after API call fails
```

**Sentinel:**
```
User runs: terraform plan
→ TFC generates plan
→ Sentinel evaluates the plan
→ DENIED: Policy check failed
→ User sees error BEFORE any Azure API calls
```

**Key Insight:** Same result, but Sentinel catches it ~30 seconds earlier with clearer error messages.

---

### Scenario 2: Naming Conventions (Only Sentinel Can Do)

**Azure Policy:** ❌ Cannot enforce resource naming patterns

**Sentinel:** ✅ Can enforce any naming convention via regex

```hcl
# Example: Require rg-{app_id}-{env} pattern
naming_patterns = {
    "azurerm_resource_group": "^rg-a[0-9]+-[a-z]+$",
}
```

**Key Insight:** Sentinel enables governance that Azure Policy cannot provide.

---

### Scenario 3: Defense in Depth

Use BOTH for comprehensive coverage:

```
Developer Code → Sentinel (TFC) → Azure Policy (Azure) → Deployed Resource
                     ↓                    ↓
                 Catch early          Catch bypasses
                 (Terraform)          (Portal, CLI, ARM)
```

## Policies in This Directory

| Policy | Enforcement | What It Checks |
|--------|-------------|----------------|
| `allowed-locations.sentinel` | soft-mandatory | Resources in approved Azure regions |
| `required-tags.sentinel` | soft-mandatory | Required governance tags present |
| `naming-conventions.sentinel` | advisory | ZNA naming standards (Sentinel-only!) |
| `security-requirements.sentinel` | hard-mandatory | TLS 1.2+, soft delete, etc. |

## Enforcement Levels

- **advisory**: Warn but allow (for rollout/testing)
- **soft-mandatory**: Fail but authorized users can override
- **hard-mandatory**: Fail with no override (security policies)

## Setting Up in Terraform Cloud

1. Create a Policy Set in TFC Organization Settings
2. Connect to VCS repository containing these policies
3. Apply to workspaces (all or specific)

```hcl
# Or via Terraform:
resource "tfe_policy_set" "azure_governance" {
  name         = "azure-governance"
  organization = "your-org"
  kind         = "sentinel"

  policy {
    source = "./policies/sentinel"
  }

  workspace_ids = [tfe_workspace.example.id]
}
```

## Example Output

### Sentinel Failure (Location):
```
═══════════════════════════════════════════════════════════════════
  SENTINEL POLICY VIOLATION: Allowed Locations
═══════════════════════════════════════════════════════════════════

  The following resources use disallowed locations:

  ❌ azurerm_resource_group.main
      Location: eastus
      Allowed:  ["southcentralus", "centralus"]

═══════════════════════════════════════════════════════════════════
```

### Azure Policy Failure (Same Scenario):
```
Error: creating Resource Group "rg-a2026013102-dev":
resources.GroupsClient#CreateOrUpdate: Failure responding to request:
StatusCode=403
Code="RequestDisallowedByPolicy"
Message="Resource 'rg-a2026013102-dev' was disallowed by policy."
PolicyAssignmentId: restrict-to-southcentralus
```

## When to Use Each

| Use Case | Recommended Tool |
|----------|------------------|
| Enforce for ALL Azure users (Portal, CLI, Terraform) | Azure Policy |
| Shift-left governance in CI/CD | Sentinel |
| Enforce naming conventions | Sentinel (only option) |
| Check Terraform code patterns | Sentinel |
| Compliance auditing | Azure Policy |
| Multi-cloud governance | Sentinel |
| Quick feedback to developers | Sentinel |
