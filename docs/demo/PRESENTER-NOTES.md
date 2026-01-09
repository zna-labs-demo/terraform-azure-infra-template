# Presenter Quick Reference

## Before You Start

### Environment Check (5 min before)
```bash
# Verify pipeline is connected
# Check ADO - Pipeline should show recent runs

# Verify TFC workspace
# Login to app.terraform.io and check workspace exists

# Verify ADO Environments
# Check QA and Production environments have approvers configured

# Pull latest changes
cd /path/to/terraform-azure-infra-template
git checkout main
git pull
```

### Browser Tabs to Have Open
1. **GitHub** - This repository
2. **Azure DevOps** - Pipeline runs view
3. **Terraform Cloud** - Workspace view
4. **Azure Portal** - Resource groups
5. **This guide** - For reference

---

## Key Talking Points

### On Quality Gates
> "Quality gates are your first line of defense. They catch issues that would
> otherwise make it to production. Think of them as automated code review."

### On Progressive Deployment
> "We deploy to dev first because it's low-risk. If something breaks in dev,
> only developers are affected. By the time we reach prod, we've validated
> the changes in two environments."

### On Approval Gates
> "Approval gates aren't about slowing things down - they're about adding
> a human checkpoint for critical environments. Someone needs to verify
> the plan looks correct before applying to QA or Production."

### On Infrastructure as Code
> "Every change is tracked in git. If something breaks, we can see exactly
> what changed, who changed it, and when. We can also roll back by reverting
> the commit."

---

## Common Demo Issues and Fixes

### Pipeline Doesn't Start
- Check: Is the pipeline connected to the repo?
- Check: Are webhooks configured?
- Fix: Manually trigger the pipeline

### TFC Authentication Fails
- Check: Is TFC_TOKEN variable set?
- Check: Is the token still valid?
- Fix: Regenerate token in TFC and update ADO variable

### Approval Not Showing
- Check: Are ADO Environments created?
- Check: Are approvers configured?
- Fix: Create environments in ADO Project Settings > Environments

### Resources Not Appearing in Azure
- Check: Is the Azure subscription correct?
- Check: Are ARM credentials configured in TFC?
- Fix: Verify TFC workspace has correct Azure credentials

---

## Timing Guide

| Section | Duration | Cumulative |
|---------|----------|------------|
| Architecture Overview | 5 min | 5 min |
| Environment Config | 5 min | 10 min |
| Create PR Demo | 10 min | 20 min |
| Failed Check Demo | 5 min | 25 min |
| Merge & Deploy | 10 min | 35 min |
| Azure Verification | 5 min | 40 min |
| Q&A | 5-10 min | 45-50 min |

---

## Audience Engagement Questions

### Opening
- "Who here has deployed infrastructure manually before?"
- "What's the scariest production deployment you've done?"

### During Quality Gates
- "What would happen if we deployed code with a syntax error?"
- "How long do you think it takes to run all these checks?"

### During Approval
- "Who should approve production deployments in your team?"
- "What information would you want to see before approving?"

### Closing
- "What questions do you have about implementing this in your projects?"

---

## Demo Commands Cheat Sheet

```bash
# Create feature branch
git checkout -b demo/enable-storage

# Stage and commit
git add environments/dev.tfvars
git commit -m "feat: enable storage account in dev"
git push -u origin demo/enable-storage

# Fix formatting
terraform fmt

# Create PR (GitHub CLI)
gh pr create --title "Enable storage account" --body "Demo PR"

# Cleanup
git checkout main
git branch -D demo/enable-storage
git push origin --delete demo/enable-storage
```

---

## Backup Plan

If the pipeline or TFC is having issues:

1. **Show recorded video** of a successful run
2. **Walk through the YAML** explaining each stage
3. **Show a completed run** in ADO pipeline history
4. **Discuss the concepts** using the architecture diagram

Remember: The goal is understanding the PROCESS, not watching a pipeline run.
