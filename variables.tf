variable "resource_group_name" {
  description = "Name of the existing resource group to deploy every resource in this module call into. This module does not create the resource group itself."
  type        = string
}

variable "location" {
  description = "Azure region for every resource created by this module call."
  type        = string
}

variable "tags" {
  description = "Default tags applied to every resource created by this module call (e.g. the output of terraform-azure-tags). Overridden per-resource by that resource's own `tags` attribute, if set."
  type        = map(string)
  default     = {}
}

variable "virtual_wans" {
  description = <<-EOT
    Map of Virtual WANs to create, keyed by an arbitrary caller-chosen map key.

    NOTE: there is no published AVM module for Virtual WAN / Virtual Hub as of this writing, so this wraps
    the native `azurerm_virtual_wan` / `azurerm_virtual_hub` resources directly. Swap in an AVM module if/when
    Microsoft publishes one.
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_wan
  EOT
  type = map(object({
    name                              = string
    type                              = optional(string, "Standard")
    disable_vpn_encryption            = optional(bool, false)
    allow_branch_to_branch_traffic    = optional(bool, true)
    office365_local_breakout_category = optional(string, null)
    tags                              = optional(map(string))
  }))
  default = {}
}

variable "virtual_hubs" {
  description = <<-EOT
    Map of Virtual Hubs to create, keyed by an arbitrary caller-chosen map key.
    `virtual_wan_key` must reference a key in var.virtual_wans.
    https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_hub
  EOT
  type = map(object({
    name                   = string
    virtual_wan_key        = string
    address_prefix         = optional(string, null)
    sku                    = optional(string, "Standard")
    hub_routing_preference = optional(string, null)
    tags                   = optional(map(string))
  }))
  default = {}
}
