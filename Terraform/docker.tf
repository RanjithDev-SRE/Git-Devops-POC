provider "azurerm" {
  features {}
}

variable "vm_ip" {
  description = "Public IP of the existing Azure VM"
  type        = string
}

variable "vm_user" {
  description = "Username for the VM"
  type        = string
}

variable "vm_password" {
  description = "Password for the VM"
  type        = string
}

resource "null_resource" "install_docker" {
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = var.vm_user
      password = var.vm_password
      host     = var.vm_ip
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo docker pull nginx",
      "sudo docker run -d -p 80:80 nginx"
    ]
  }
}
