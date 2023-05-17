terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.56.0"
    }
  }
}

provider "azurerm" {
  features {}
  client_id                   = "17464bb0-3e4e-4df3-893f-68ff29fd47f6"
  client_secret               = "U3M8Q~D0DZUFHzM2Zn4.2qWwBrI46O2wutHuGbjH"
  tenant_id                   = "a4580296-9f34-4ce7-86f7-9dbf03aafbba"
  subscription_id             = "2109209e-3579-4fcb-a302-b5f5e4020c84"
  
}
resource "azurerm_resource_group" "rg" {
   name     = var.azurerm_resource_group-name
   location = var.location
}

resource "azurerm_virtual_network" "vnet1" {
  name                = var.azurerm_virtual_network-name
  location            = var.location
  resource_group_name = var.azurerm_resource_group-name
  address_space       = var.address_space
  
}
resource "azurerm_subnet" "subnet01" {
  name                = var.azurerm_subnet01
  resource_group_name = var.azurerm_resource_group-name
  address_prefixes    = var.address_prefixes01
  virtual_network_name = var.azurerm_virtual_network-name
}
resource "azurerm_subnet" "subnet02" {
  name                = var.azurerm_subnet02
  resource_group_name = var.azurerm_resource_group-name
  address_prefixes    = var.address_prefixes02
  virtual_network_name = var.azurerm_virtual_network-name
}
resource "azurerm_subnet" "subnet03" {
  name                = var.azurerm_subnet03
  resource_group_name = var.azurerm_resource_group-name
  address_prefixes    = var.address_prefixes03
  virtual_network_name = var.azurerm_virtual_network-name
}
resource "azurerm_network_security_group" "nsg" {
  name                = var.azurerm_network_security_group
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
}