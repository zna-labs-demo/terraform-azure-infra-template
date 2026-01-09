# CI/CD Demo Materials

This folder contains materials for the 200-level Terraform CI/CD live demo.

## Contents

| File | Description |
|------|-------------|
| [LIVE-DEMO-GUIDE.md](LIVE-DEMO-GUIDE.md) | Complete demo script with step-by-step instructions |
| [PRESENTER-NOTES.md](PRESENTER-NOTES.md) | Quick reference, talking points, and troubleshooting |
| [samples/](samples/) | Sample code changes for different demo scenarios |

## Quick Start

### 1. Prepare (10 min before demo)

```bash
# Ensure you're on main and up to date
git checkout main
git pull

# Verify the pipeline is working
# Check Azure DevOps for recent successful runs
```

### 2. Run the Demo

Follow [LIVE-DEMO-GUIDE.md](LIVE-DEMO-GUIDE.md) for the complete walkthrough.

### 3. Cleanup After Demo

```bash
# Delete any demo branches
git checkout main
git branch -D demo/enable-storage 2>/dev/null
git push origin --delete demo/enable-storage 2>/dev/null
```

## Sample Scenarios

| Scenario | File | What it Demonstrates |
|----------|------|---------------------|
| Happy Path | `samples/01-enable-storage.patch` | Successful PR and deployment |
| Format Failure | `samples/02-bad-formatting.tf` | TerraformFormat check failing |
| Validation Error | `samples/03-validation-error.tf` | TerraformValidate check failing |
| Security Issues | `samples/04-security-issues.tf` | tfsec security scan findings |

## Prerequisites

Before running the demo, ensure:

- [ ] Azure DevOps pipeline is connected and working
- [ ] `TFC_TOKEN` secret is configured in ADO
- [ ] ADO Environments (`QA`, `Production`) have approval gates
- [ ] Terraform Cloud workspace is accessible
- [ ] You have push access to the repository
