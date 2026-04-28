resource "azurerm_resource_group" "rg" {
  name     = "rg-nat-nva-opnsense-${var.prefix}"
  location = "switzerlandnorth"
}
