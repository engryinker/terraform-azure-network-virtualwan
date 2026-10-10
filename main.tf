resource "azurerm_virtual_wan" "this" {
  for_each = var.virtual_wans

  name                              = each.value.name
  resource_group_name               = var.resource_group_name
  location                          = var.location
  type                              = each.value.type
  disable_vpn_encryption            = each.value.disable_vpn_encryption
  allow_branch_to_branch_traffic    = each.value.allow_branch_to_branch_traffic
  office365_local_breakout_category = each.value.office365_local_breakout_category
  tags                              = coalesce(each.value.tags, var.tags)
}

resource "azurerm_virtual_hub" "this" {
  for_each = var.virtual_hubs

  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  location               = var.location
  virtual_wan_id         = azurerm_virtual_wan.this[each.value.virtual_wan_key].id
  address_prefix         = each.value.address_prefix
  sku                    = each.value.sku
  hub_routing_preference = each.value.hub_routing_preference
  tags                   = coalesce(each.value.tags, var.tags)
}
