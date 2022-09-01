provider "azurerm" {
  features {}

  subscription_id = "e0501216-ce98-4f21-a933-120bd94fda71"
  client_id       = "c530ca01-1069-4cd7-ab27-e3ee1d382fd0"
  client_secret   = "4b18Q~BywNhfl~nUR1d33~3wVloKZHNyLcZ6laCA"
  tenant_id       = "cd7a9d48-7933-401c-8092-29a5ad3b7e85"
}

resource "azurerm_resource_group" "dev" {
  name     = var.azurerm_resource_group-name
  location = var.location
}
resource "azurerm_virtual_network" "dvnet" {
  name                = var.azurerm_virtual_network-name 
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.azurerm_resource_group-name
depends_on = [
  azurerm_resource_group.dev
]
}

resource "azurerm_subnet" "subnet01" {
  name                 = var.azurerm_subnet01
  resource_group_name  = var.azurerm_resource_group-name
  virtual_network_name = var.azurerm_virtual_network-name
  address_prefixes     = var.address_prefix01
depends_on = [
  azurerm_virtual_network.dvnet
]
}

resource "azurerm_subnet" "subnet02" {
  name                 = var.azurerm_subnet02
  resource_group_name  = var.azurerm_resource_group-name
  virtual_network_name = var.azurerm_virtual_network-name
  address_prefixes     = var.address_prefix02
depends_on = [
  azurerm_virtual_network.dvnet
]

}

resource "azurerm_subnet" "subnet03" {
  name                 = var.azurerm_subnet03
  resource_group_name  = var.azurerm_resource_group-name
  virtual_network_name = var.azurerm_virtual_network-name
  address_prefixes     = var.address_prefix03
depends_on = [
  azurerm_virtual_network.dvnet
]

}

resource "azurerm_network_security_group" "dnsg" {
  name                = var.azurerm_network_security_group-name
  location            = var.location
  resource_group_name = var.azurerm_resource_group-name

  security_rule {
    name                       = var.name
    priority                   = var.priority
    direction                  = var.direction
    access                     = var.access
    protocol                   = var.protocol
    source_port_range          = var.source_port_range
    destination_port_range     = var.destination_port_range
    source_address_prefix      = var.source_address_prefix
    destination_address_prefix = var.destination_address_prefix
  }
depends_on = [
  azurerm_resource_group.dev
]
}

