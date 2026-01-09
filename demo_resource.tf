# Demo resource with formatting issues
# This file intentionally has bad formatting to demonstrate quality gates

variable "demo_var" {
description = "Demo variable with bad formatting"
    type = string
  default     =    "demo"
}

resource "azurerm_resource_group" "demo"{
name     = "rg-demo-formatting"
  location = var.location
tags = {
demo = "true"
  }
}
