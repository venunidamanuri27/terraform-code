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
   name     = "lik11_rg"
   location = "East US"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "Terraform_nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "terraform11"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_public_ip" "terraform_public" {
  name                = "terramform_public"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}
resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.terraform_public.id
  }
}

resource "azurerm_virtual_network" "terraform_vnet" {
  name                = "terraform_vnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  
}
resource "azurerm_subnet" "subnet1" {
  name                = "subnet1"
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = ["10.0.0.0/24"]
  virtual_network_name = azurerm_virtual_network.terraform_vnet.name
}
resource "azurerm_subnet" "subnet2" {
  name                = "subnet2"
  resource_group_name = azurerm_resource_group.rg.name
  address_prefixes = ["10.0.1.0/24"]
  virtual_network_name = azurerm_virtual_network.terraform_vnet.name
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "terraformvm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  vm_size               = "Standard_B1s"


  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "KING"
    admin_username = "venu"
    admin_password = "Nvenu@207"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}