
resource "openstack_compute_keypair_v2" "lamp-key" {
  name = "lamp-key"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}

resource "openstack_compute_instance_v2" "wordpress" {
  name = "wordpress"
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
      "mkdir -p ~/scripts ~/app"
    ]
  }

  provisioner "file" {
    source = "scripts/lampstack.sh"
    destination = "~/scripts/lampstach.sh"
  }

  provisioner "file" {
    source = "app/limesurvey.zip"
    destination = "~/app"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/scripts/lampstack.sh",
      "~/scripts/lampstack.sh"
    ]
  }


}
