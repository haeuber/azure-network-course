resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-hub"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.1.0.0/28"]
  dns_servers         = null
}

resource "azurerm_subnet" "snet-untrusted" {
  name                            = "snet-untrusted"
  resource_group_name             = azurerm_virtual_network.vnet-hub.resource_group_name
  virtual_network_name            = azurerm_virtual_network.vnet-hub.name
  address_prefixes                = ["10.1.0.0/29"]
  default_outbound_access_enabled = true
}

resource "azurerm_subnet" "snet-trusted" {
  name                            = "snet-trusted"
  resource_group_name             = azurerm_virtual_network.vnet-hub.resource_group_name
  virtual_network_name            = azurerm_virtual_network.vnet-hub.name
  address_prefixes                = ["10.1.0.8/29"]
  default_outbound_access_enabled = true
}