#Configure Azure provider
provider "azurerm" {
  features {}
}

#Get Packer image
data "azurerm_image" "packer-image" {
  name                = "udacityPackerImage"
  resource_group_name = "udacity-rg"
}

#Create resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-TFRG"
  location = var.location
  tags     = var.tags
}

# Create network security group and rules
resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}-TFNSG"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "ruleAllowHTTPVnetInboundFromInternet" {
    name                       = "AllowHTTPVnetInboundFromInternet"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "ruleDenyAllVnetInboundFromInternet" {
    name                       = "DenyAllVnetInboundFromInternet"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    resource_group_name         = azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
  }

# Create virtual network
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-TFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags
}

# Create subnet
resource "azurerm_subnet" "main" {
  name                 = "${var.prefix}-TFSubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

#Create subnet network security group association
resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = azurerm_subnet.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# Create network interface
resource "azurerm_network_interface" "main" {
    count               = var.VMnum
    name                = "${var.prefix}-NIC-${count.index}"
    location            = var.location
    resource_group_name = azurerm_resource_group.main.name
    tags                = var.tags

  ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.main.id
        private_ip_address_allocation = "dynamic"
        primary                       = true
    }
}

# Create public IP
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-TFPublicIP"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  tags                = var.tags
}

# Create load balancer
resource "azurerm_lb" "main" {
  name                = "${var.prefix}-LB"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_probe" "main" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
  name                = "http-probe"
  port                = 80
}

resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id     = azurerm_lb.main.id
  name                = "${var.prefix}-backendAddrPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "main" {
  count                   = var.VMnum
  network_interface_id    = azurerm_network_interface.main[count.index].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}

resource "azurerm_lb_rule" "main" {
  resource_group_name            = azurerm_resource_group.main.name
  loadbalancer_id                = azurerm_lb.main.id
  name                           = "HTTP"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.main.frontend_ip_configuration[0].name
  probe_id                       = azurerm_lb_probe.main.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.main.id
}

# Create virtual machine availability set
resource "azurerm_availability_set" "main" {
  name                        = "${var.prefix}-avaset"
  location                    = var.location
  resource_group_name         = azurerm_resource_group.main.name
  platform_fault_domain_count = 2
  tags                        = var.tags
}

# Create a Linux virtual machine
resource "azurerm_virtual_machine" "main" {
  count                 = var.VMnum
  name                  = "${var.prefix}-TFVM-${count.index}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [element(azurerm_network_interface.main.*.id, count.index)]
  availability_set_id   = azurerm_availability_set.main.id
  vm_size               = "Standard_DS1_v2"
  tags                  = var.tags

  storage_image_reference {
   id = data.azurerm_image.packer-image.id
 }
  
  storage_os_disk {
    name              = "${var.prefix}-OsDisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-TFVM"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_managed_disk" "main" {
  count                = var.VMnum
  name                 = "${var.prefix}-datadisk-${count.index}"
  location             = var.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 1
}

resource "azurerm_virtual_machine_data_disk_attachment" "main" {
  count              = var.VMnum
  managed_disk_id    = azurerm_managed_disk.main[count.index].id
  virtual_machine_id = azurerm_virtual_machine.main[count.index].id
  lun                = 10 * count.index
  caching            = "ReadWrite"
}

# Load balancer output
output "lb_url" {
  value       = "http://${azurerm_public_ip.main.ip_address}/"
  description = "Public URL of the load balancer."
}