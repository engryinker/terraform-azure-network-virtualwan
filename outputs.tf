output "virtual_wans" {
  description = "Map (same keys as var.virtual_wans) of the created azurerm_virtual_wan resources."
  value       = azurerm_virtual_wan.this
}

output "virtual_hubs" {
  description = "Map (same keys as var.virtual_hubs) of the created azurerm_virtual_hub resources."
  value       = azurerm_virtual_hub.this
}
