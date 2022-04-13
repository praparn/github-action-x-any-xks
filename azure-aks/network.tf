 resource "azurerm_virtual_network" "virtual_network" {
  name =  "${var.cluster_name}-vnet"
  location = var.location
  resource_group_name = var.resource_group
  address_space = [var.network_space]
}
 
resource "azurerm_subnet" "aks_subnet" {
  name = "${var.cluster_name}-aksvnet"
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes = [var.network_space_aks]
}