resource "null_resource" "devops_tools_install" {

  depends_on = [
    azurerm_linux_virtual_machine.vm
  ]

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"

    connection {
      type        = "ssh"
      user        = var.username
      password    = var.password
      host        = azurerm_linux_virtual_machine.vm.public_ip_address
    }
  }

  provisioner "remote-exec" {

    connection {
      type        = "ssh"
      user        = var.username
      password    = var.password
      host        = azurerm_linux_virtual_machine.vm.public_ip_address
    }

    inline = [
      "chmod +x /tmp/install.sh",
      "sudo /tmp/install.sh"
    ]
  }

}