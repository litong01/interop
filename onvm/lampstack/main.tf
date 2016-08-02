
resource "openstack_compute_keypair_v2" "lamp-key" {
  name = "lamp-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "openstack_compute_instance_v2" "limesurvey" {
  name = "limesurvey"
  image_name = "${var.image}"
  flavor_name = "${var.flavor}"
  key_pair = "lamp-key"
  security_groups = [ "default" ]
  network {
    name = "Bluebox"
  }

  connection {
    user = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    timeout = "30s"
  }

  provisioner "remote-exec" {
    inline = [
      "echo \"127.0.0.1    `hostname`\" | sudo tee -a /etc/hosts >/dev/null",
      "mkdir -p ~/scripts ~/app"
    ]
  }

  provisioner "file" {
    source = "scripts/lampstack.sh"
    destination = "~/scripts/lampstack.sh"
  }

  provisioner "file" {
    source = "app/limesurvey.zip"
    destination = "~/app/limesurvey.zip"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/scripts/lampstack.sh",
      "~/scripts/lampstack.sh"
    ]
  }


}
