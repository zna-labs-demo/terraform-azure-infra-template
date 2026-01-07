# =============================================================================
# Provider Configuration
# =============================================================================
# This file configures the required providers for Azure infrastructure deployment.
# The Azure subscription is automatically configured via TFC workspace variables.
# =============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }

  # Terraform Cloud workspace configuration
  # The workspace is automatically created by the subscription vending process
  cloud {
    organization = "zna-labs"

    workspaces {
      tags = ["managed-by:subscription-vending"]
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }

  # Subscription ID is injected via TFC workspace environment variable
  # ARM_SUBSCRIPTION_ID is set automatically by the vending process
}
