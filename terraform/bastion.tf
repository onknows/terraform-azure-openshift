
resource "azurerm_network_interface" "bastion" {
  name                      = "openshift-bastion-nic"
  location                  = "${var.azure_location}"
  resource_group_name       = "${azurerm_resource_group.openshift.name}"
  network_security_group_id = "${azurerm_network_security_group.bastion.id}"

  ip_configuration {
    name                          = "default"
    public_ip_address_id          = "${var.bastion-public-ip}"
    subnet_id                     = "${azurerm_subnet.other.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_network_security_group" "bastion" {
  name                = "openshift-bastion-security-group"
  location            = "${var.azure_location}"
  resource_group_name = "${azurerm_resource_group.openshift.name}"
}

resource "azurerm_network_security_rule" "bastion-ssh" {
  name                        = "bastion-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  source_port_range           = "*"
  destination_port_range      = 22
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.openshift.name}"
  network_security_group_name = "${azurerm_network_security_group.bastion.name}"
}


resource "azurerm_virtual_machine" "bastion" {
  name                  = "openshift-bastion-vm"
  location              = "${var.azure_location}"
  resource_group_name   = "${azurerm_resource_group.openshift.name}"
  network_interface_ids = ["${azurerm_network_interface.bastion.id}"]
  vm_size               = "${var.bastion_vm_size}"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04.0-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "openshift-bastion-vm-os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  os_profile {
    computer_name  = "bastion"
    admin_username = "${var.admin_user}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.admin_user}/.ssh/authorized_keys"
      key_data = "${file("${path.module}/../certs/bastion.pub")}"
    }
  }

  # provisioner "remote-exec" {
  #  script = "${path.module}/provision/bastion.sh"
  #
  #  connection {
  #    type        = "ssh"
  #    host        = "${azurerm_public_ip.bastion.ip_address}"
  #    user        = "${var.admin_user}"
  #    private_key = "${file("${path.module}/../certs/bastion.key")}"
  #  }
  # }
}
