## Create the VM in Azure

#resource "azurerm_resource_group" "example" {
 # name     = "example-resources"
  #location = "West Europe"
#}

# resource "azurerm_network_security_group" "example" {
#   name                = "example-security-group"
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

#0. Create or use RG with variable and define with statically

#1.Create Virtual Network in each region 
resource "azurerm_virtual_network" "example" {
for_each = var.virtual_network_configurations
  name                = each.value.name
  location            = each.value.location
  resource_group_name = 
  address_space       = each.value.address_space
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    for_each = each.value.subnet_configurations
    name           = each.key
    address_prefix = each.value
  }


  tags = {
   for_each = each.value.tags
    environment = each.value
  }
}
#2. Create Subnet

#3.Create NICs

#4. Create VM



# Create VM is each location.
resource "azurerm_virtual_network" "example" {
  for_each = var.resource_configurations

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-${each.key}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}

resource "azurerm_network_interface" "example" {
  for_each = var.resource_configurations

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = "rg1"
  virtual_network_name = "vnet1"
  address_prefixes     = ["10.0.1.0/24"]
}