
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
      "mkdir -p ~/scripts"
    ]
  }

  provisioner "file" {
    source = "scripts/lampsetup.sh"
    destination = "~/scripts/lampsetup.sh"
  }

}
