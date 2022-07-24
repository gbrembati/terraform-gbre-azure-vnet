output "resource-group-ids" {
  description = "The id of the newly created vNet"
  value       = azurerm_resource_group.rg-vnet-spoke[*].id
}
output "resource-group-names" {
  description = "The id of the newly created vNet"
  value       = azurerm_resource_group.rg-vnet-spoke[*].name
}

output "vnet-id" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke[*].id
}
output "vnet-name" {
  description = "The Name of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke[*].name
}
output "vnet-address-space" {
  description = "The address space of the newly created vNet"
  value       = azurerm_virtual_network.vnet-spoke[*].address_space
}

output "subnet-A-id" {
  description = "The address space of the newly created vNet"
  value       = azurerm_subnet.net-spoke-subnet-A[*].id
}
output "subnet-B-id" {
  description = "The address space of the newly created vNet"
  value       = azurerm_subnet.net-spoke-subnet-B[*].id
}
output "subnet-C-id" {
  description = "The address space of the newly created vNet"
  value       = azurerm_subnet.net-spoke-subnet-C[*].id
}