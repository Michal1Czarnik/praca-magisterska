resource "azurerm_network_interface" "network_interface" {
  name                = azurecaf_name.nic.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name
  dns_servers         = var.settings.dns_servers

  ip_configuration {
    name                          = azurecaf_name.nic.result
    subnet_id                     = lookup(var.subnets, var.settings.subnet_key)
    private_ip_address_allocation = var.settings.private_ip_address == null ? "Dynamic" : "Static"
    private_ip_address            = var.settings.private_ip_address
  }
}

resource "azurerm_linux_virtual_machine" "linux_virtual_machine" {
  name                = azurecaf_name.linux_vm.result
  location            = coalesce(var.settings.location, var.global_settings.default_location)
  resource_group_name = var.resource_group_name

  size                  = var.settings.size
  admin_username        = var.settings.admin_username
  network_interface_ids = [azurerm_network_interface.network_interface.id]

  disable_password_authentication = true

  custom_data = var.settings.custom_data

  admin_ssh_key {
    username   = var.settings.admin_username
    public_key = var.settings.public_key
  }

  os_disk {
    disk_size_gb         = var.settings.os_disk.disk_size_gb
    caching              = var.settings.os_disk.caching
    storage_account_type = var.settings.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.settings.source_image_reference.publisher
    offer     = var.settings.source_image_reference.offer
    sku       = var.settings.source_image_reference.sku
    version   = var.settings.source_image_reference.version
  }
}