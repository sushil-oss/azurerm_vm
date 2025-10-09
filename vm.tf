resource "azurerm_virtual_network" "vnet0" {
  name                = "my-vnet1"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg22.location
  resource_group_name = azurerm_resource_group.rg22.name
}

resource "azurerm_subnet" "sub0" {
  name                 = "my-sub1"
  resource_group_name  = azurerm_resource_group.rg22.name
  virtual_network_name = azurerm_virtual_network.vnet0.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "net0" {
  name                = "my-net1"
  location            = azurerm_resource_group.rg22.location
  resource_group_name = azurerm_resource_group.rg22.name

  ip_configuration {
    name                          = "my-testconfig1"
    subnet_id                     = azurerm_subnet.sub0.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm0" {
  name                  = "my-vm1"
  location              = azurerm_resource_group.rg22.location
  resource_group_name   = azurerm_resource_group.rg22.name
  network_interface_ids = [azurerm_network_interface.net0.id]
  vm_size               = "Standard_D2s_v3"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }

}
