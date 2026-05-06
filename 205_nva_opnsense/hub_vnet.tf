resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space_nat
  dns_servers         = null
}

resource "azurerm_subnet" "snet-untrusted" {
  name                            = "snet-untrusted"
  resource_group_name             = azurerm_virtual_network.vnet-hub.resource_group_name
  virtual_network_name            = azurerm_virtual_network.vnet-hub.name
  address_prefixes                = [cidrsubnets(var.address_space_nat[0], 1)[0]]
  default_outbound_access_enabled = true
}

resource "azurerm_subnet" "snet-trusted" {
  name                            = "snet-trusted"
  resource_group_name             = azurerm_virtual_network.vnet-hub.resource_group_name
  virtual_network_name            = azurerm_virtual_network.vnet-hub.name
  address_prefixes                = [cidrsubnets(var.address_space_nat[0], 1, 1)[1]]
  default_outbound_access_enabled = true
}