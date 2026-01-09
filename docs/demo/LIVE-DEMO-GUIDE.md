# Live Demo: Terraform CI/CD Pipeline (200-Level)

## Overview

This demo walks through a complete CI/CD pipeline for Terraform infrastructure, demonstrating:
- Pull Request quality gates
- Progressive environment promotion (Dev → QA → Prod)
- Azure DevOps Environment approval gates
- Terraform Cloud integration

**Duration:** 30-45 minutes
**Audience:** Teams familiar with Terraform basics, learning CI/CD practices

---

## Pre-Demo Setup Checklist

### Azure DevOps Setup
- [ ] Pipeline connected to this repository
- [ ] `TFC_TOKEN` variable configured (secret)
- [ ] ADO Environment `QA` created with approval gate
- [ ] ADO Environment `Production` created with approval gate

### Terraform Cloud Setup
- [ ] Workspace exists with tag `managed-by:subscription-vending`
- [ ] Azure credentials configured in workspace

### Demo Preparation
- [ ] Clone this repository locally
- [ ] Create demo branch: `git checkout -b demo/add-storage-account`
- [ ] Have Azure Portal open to show resources
- [ ] Have ADO Pipeline view ready

---

## Demo Script

### Part 1: Architecture Overview (5 min)

**Show:** `azure-pipelines.yml`

> "Let me walk you through our CI/CD pipeline architecture. We have 5 stages that handle different parts of the deployment lifecycle."

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           PULL REQUEST                                       │
│  ┌──────────────┐                                                           │
│  │ Quality Gates│ ← Format, Validate, TFLint, Security Scan                 │
│  └──────┬───────┘                                                           │
│         │                                                                    │
│         ▼                                                                    │
│  ┌──────────────┐                                                           │
│  │    Plan      │ ← Generate plan summary for review                        │
│  └──────────────┘                                                           │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│                           MERGE TO MAIN                                      │
│  ┌──────────────┐                                                           │
│  │ Quality Gates│ ← Same checks run again                                   │
│  └──────┬───────┘                                                           │
│         │                                                                    │
│         ▼                                                                    │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                   │
│  │     Dev      │───▶│      QA      │───▶│    Prod      │                   │
│  │  (Auto)      │    │  (Approval)  │    │  (Approval)  │                   │
│  └──────────────┘    └──────────────┘    └──────────────┘                   │
└─────────────────────────────────────────────────────────────────────────────┘
```

**Key Points:**
- Quality gates run on EVERY code change (PR and main)
- Dev deploys automatically after quality gates pass
- QA and Prod require human approval via ADO Environments

---

### Part 2: Environment Configuration (5 min)

**Show:** `environments/` folder

> "Each environment has its own configuration file. Let's look at how they differ."

| File | Tier | Env Code | Purpose |
|------|------|----------|---------|
| `dev.tfvars` | n (non-prod) | d | Development testing |
| `qa.tfvars` | n (non-prod) | q | Quality assurance |
| `prod.tfvars` | p (prod) | p | Production workloads |

**Show:** Differences between files

```bash
# In terminal, show the key differences
diff environments/dev.tfvars environments/prod.tfvars
```

**Key Points:**
- Secrets are NOT in tfvars (they come from TFC/Key Vault)
- Environment-specific settings live here
- ZNA naming convention ensures unique resource names

---

### Part 3: Live Demo - Create a PR (10 min)

#### Step 3a: Make a Change

> "Let's enable a storage account in dev. Watch what happens when we create a PR."

```bash
# Create feature branch
git checkout -b demo/enable-storage

# Edit environments/dev.tfvars
# Change: enable_storage_account = false
# To:     enable_storage_account = true
```

**Make the edit live** - show the audience the change

#### Step 3b: Create Pull Request

```bash
git add environments/dev.tfvars
git commit -m "feat: enable storage account in dev environment"
git push -u origin demo/enable-storage
```

**In GitHub:** Create the PR

> "Notice the pipeline automatically starts running. Let's watch the quality gates."

#### Step 3c: Watch Quality Gates

**In ADO Pipeline View:**

1. **TerraformFormat** - "Checks that code follows formatting standards"
2. **TerraformValidate** - "Validates the Terraform configuration syntax"
3. **TFLint** - "Runs static analysis for best practices"
4. **SecurityScan** - "Scans for security issues with tfsec"

> "All these run in parallel to save time. If ANY fail, the PR cannot be merged."

#### Step 3d: Show Plan Stage

> "After quality gates pass, we generate a plan summary. In a real scenario,
> reviewers would check this before approving the PR."

---

### Part 4: Demonstrate a Failed Check (5 min)

> "Let me show you what happens when code doesn't meet our standards."

#### Create a formatting issue:

```bash
# Create a new branch
git checkout main
git checkout -b demo/bad-format

# Edit variables.tf - add bad formatting
# Add extra spaces, wrong indentation, etc.
```

**Show the pipeline failing on TerraformFormat**

> "This is why we have quality gates - they catch issues before they reach production."

```bash
# Fix it with terraform fmt
terraform fmt

# Commit the fix
git add .
git commit -m "fix: correct formatting"
git push
```

---

### Part 5: Merge and Deploy (10 min)

#### Step 5a: Merge the PR

> "Now let's merge our storage account change and watch the deployment pipeline."

**In GitHub:** Merge the PR

#### Step 5b: Watch Dev Deployment

**In ADO Pipeline View:**

> "Quality gates run again on main - we never skip checks, even for merged code."

**Show Dev stage:**
- Terraform Init
- Terraform Plan with `environments/dev.tfvars`
- Terraform Apply

> "Dev deploys automatically. No approval needed for dev - we want fast feedback."

#### Step 5c: QA Approval Gate

> "Now the pipeline pauses. It's waiting for approval to proceed to QA."

**Show ADO Environment approval interface**

> "This is where your QA lead or designated approver reviews and approves."

**Click Approve** - show the QA deployment starting

#### Step 5d: Production Approval Gate

> "Same process for production, but typically requires different approvers."

**Show the Production approval pending**

> "In a real scenario, you might have:
> - Multiple approvers required
> - Business hours restrictions
> - Change management ticket requirements"

---

### Part 6: Verify in Azure Portal (5 min)

**In Azure Portal:**

> "Let's verify our storage account was created in the dev environment."

1. Navigate to Resource Groups
2. Find the resource group matching ZNA naming pattern
3. Show the storage account

**Key Points:**
- Resources follow naming convention
- Tags show environment, managed-by, app_id
- Infrastructure matches code

---

## Demo Scenarios

### Scenario A: Security Issue Detection

1. Add a resource with a security issue (e.g., storage account with public access)
2. Show tfsec catching it
3. Discuss remediation

### Scenario B: Validation Failure

1. Reference a variable that doesn't exist
2. Show terraform validate failing
3. Fix and re-run

### Scenario C: Plan Review

1. Make a destructive change (e.g., rename a resource)
2. Show the plan output indicating destroy/create
3. Discuss the importance of plan review

---

## Common Questions

### Q: What if I need to bypass approval for an emergency?

> "ADO Environments can be configured with bypass permissions for emergencies,
> but this should be audited and rare. The approval process exists to prevent
> outages, not cause them."

### Q: Can we deploy to just one environment?

> "The pipeline is sequential by design. If you only want to deploy to dev,
> you can let the pipeline pause at QA and not approve it. For environment-specific
> deployments, you could create separate pipelines."

### Q: How do we handle secrets?

> "Secrets never go in tfvars. They're stored in:
> - Terraform Cloud workspace variables (marked sensitive)
> - Azure Key Vault (referenced by Terraform)
> - ADO Pipeline variables (for TFC_TOKEN)"

### Q: What if the pipeline fails mid-deployment?

> "Terraform maintains state, so you can re-run the pipeline.
> It will pick up where it left off. For critical failures,
> check the TFC workspace for detailed logs."

---

## Cleanup After Demo

```bash
# Delete demo branches
git checkout main
git branch -D demo/enable-storage
git branch -D demo/bad-format
git push origin --delete demo/enable-storage
git push origin --delete demo/bad-format

# Revert changes if needed
git revert HEAD
git push
```

---

## Additional Resources

- [Terraform Cloud Documentation](https://developer.hashicorp.com/terraform/cloud-docs)
- [Azure DevOps Environments](https://learn.microsoft.com/en-us/azure/devops/pipelines/process/environments)
- [tfsec Security Scanner](https://aquasecurity.github.io/tfsec/)
- [TFLint](https://github.com/terraform-linters/tflint)
