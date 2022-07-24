resource "azurerm_resource_group" "rg-vnet-spoke" {
  count = length(var.cidr-spoke)
  name = "rg-v${var.net-spoke}-${count.index}"
  location = var.location

  tags = {
    owner       = var.deployment-tags.owner
    managed-by  = var.deployment-tags.managed-by
  }
}
resource "azurerm_network_security_group" "nsg-vnet-spoke" {
  count = length(var.cidr-spoke)
  name  = "nsg-${azurerm_virtual_network.vnet-spoke[count.index].name}"
  location = azurerm_resource_group.rg-vnet-spoke[count.index].location
  resource_group_name = azurerm_resource_group.rg-vnet-spoke[count.index].name

  tags = {
    owner       = var.deployment-tags.owner
    managed-by  = var.deployment-tags.managed-by
  }
}
resource "azurerm_virtual_network" "vnet-spoke" {
  count = length(var.cidr-spoke)
  name = "vnet-${lookup(var.name-spoke, count.index)[0]}"
  address_space = ["${lookup(var.cidr-spoke, count.index)[0]}"]
  location = azurerm_resource_group.rg-vnet-spoke[count.index].location
  resource_group_name = azurerm_resource_group.rg-vnet-spoke[count.index].name

  tags = {
    owner       = var.deployment-tags.owner
    managed-by  = var.deployment-tags.managed-by
  }
}
resource "azurerm_subnet" "net-spoke-subnet-A" {
  count = length(var.cidr-spoke)
  name  = "net-${lookup(var.name-spoke, count.index)[0]}-${lookup(var.name-spoke, count.index)[1]}"
  address_prefixes      = ["${lookup(var.cidr-spoke, count.index)[1]}"]
  virtual_network_name  = azurerm_virtual_network.vnet-spoke[count.index].name
  resource_group_name   = azurerm_resource_group.rg-vnet-spoke[count.index].name
}
resource "azurerm_subnet" "net-spoke-subnet-B" {
  count = length(var.cidr-spoke)
  name = "net-${lookup(var.name-spoke, count.index)[0]}-${lookup(var.name-spoke, count.index)[2]}"
  address_prefixes      = ["${lookup(var.cidr-spoke, count.index)[2]}"]
  virtual_network_name  = azurerm_virtual_network.vnet-spoke[count.index].name
  resource_group_name   = azurerm_resource_group.rg-vnet-spoke[count.index].name
}
resource "azurerm_subnet" "net-spoke-subnet-C" {
  count = length(var.cidr-spoke)
  name = "net-${lookup(var.name-spoke, count.index)[0]}-${lookup(var.name-spoke, count.index)[3]}"
  address_prefixes      = ["${lookup(var.cidr-spoke, count.index)[3]}"]
  virtual_network_name  = azurerm_virtual_network.vnet-spoke[count.index].name
  resource_group_name   = azurerm_resource_group.rg-vnet-spoke[count.index].name
}

# 'next_hop_type' allowed values 
locals { next_hop_type_allowed_values = ["VirtualNetworkGateway","VnetLocal","Internet","VirtualAppliance","None"] }
resource "azurerm_route_table" "rt-vnet-spoke" {
  count = length(var.cidr-spoke)
  name      = "rt-${azurerm_virtual_network.vnet-spoke[count.index].name}"
  location  = azurerm_resource_group.rg-vnet-spoke[count.index].location
  resource_group_name = azurerm_resource_group.rg-vnet-spoke[count.index].name

  route {
    name = "route-to-internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = local.next_hop_type_allowed_values[2]
  }
  route {
    name = "route-to-vnet-addrspace"
    address_prefix = azurerm_virtual_network.vnet-spoke[count.index].address_space[0]
    next_hop_type  = local.next_hop_type_allowed_values[1]
  }  
  depends_on = [azurerm_resource_group.rg-vnet-spoke]
}

resource "azurerm_subnet_route_table_association" "rt-assoc-net-spoke-A" {
  count = length(var.cidr-spoke)
  subnet_id      = azurerm_subnet.net-spoke-subnet-A[count.index].id
  route_table_id = azurerm_route_table.rt-vnet-spoke[count.index].id
}
resource "azurerm_subnet_route_table_association" "rt-assoc-net-subnet-B" {
  count = length(var.cidr-spoke)
  subnet_id      = azurerm_subnet.net-spoke-subnet-B[count.index].id
  route_table_id = azurerm_route_table.rt-vnet-spoke[count.index].id
}
resource "azurerm_subnet_route_table_association" "rt-assoc-net-subnet-C" {
  count = length(var.cidr-spoke)
  subnet_id      = azurerm_subnet.net-spoke-subnet-C[count.index].id
  route_table_id = azurerm_route_table.rt-vnet-spoke[count.index].id
}