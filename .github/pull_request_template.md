## Description

<!-- Describe your changes in detail -->

## Type of Change

- [ ] New infrastructure resource
- [ ] Modification to existing resource
- [ ] Configuration change
- [ ] Bug fix
- [ ] Documentation update

## Checklist

### Before Submitting
- [ ] I have run `terraform fmt -recursive` to format my code
- [ ] I have run `terraform validate` to check for errors
- [ ] I have run `tflint` to check for best practices
- [ ] I have tested these changes in a development environment (if applicable)

### Security
- [ ] No secrets or sensitive values are hardcoded
- [ ] No unnecessary permissions are granted
- [ ] Resources follow least-privilege principle

### Documentation
- [ ] I have updated the README if needed
- [ ] I have added comments to complex logic
- [ ] Variable and output descriptions are clear

## Resources Changed

<!-- List the resources that will be created/modified/destroyed -->

| Action | Resource Type | Resource Name |
|--------|--------------|---------------|
| Create | `azurerm_...` | `name` |

## Testing

<!-- How did you test these changes? -->

## Related Links

<!-- Link to related issues, ADO work items, or documentation -->

- Closes #
- ADO Work Item:
- TFC Workspace: [View Plan](https://app.terraform.io/app/zna-labs/workspaces)
