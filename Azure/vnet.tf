resource "azurerm_virtual_network" "this" {
  name                = var.project_name
  address_space       = [var.vnet_cidr]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

resource "azurerm_subnet" "agw" {
  name                 = "agw"
  address_prefixes     = ["10.0.101.0/24"]
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
}

resource "azurerm_public_ip" "agw" {
  name                = "agw"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"
}