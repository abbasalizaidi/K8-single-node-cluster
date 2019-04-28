provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "kubernetes" {
  ami           = "${var.ami_version}"
  instance_type = "${var.instance_type}"
  subnet_id = "${aws_subnet.kube_subnet.id}"
  security_groups = [ "${aws_security_group.kube_security.id}" ]
  key_name = "kube_keypair"
  root_block_device {
    volume_size = "${var.root_block_device}"
  }
  tags {
  Name = "Kubernetes"
 }

 } 

resource "aws_eip" "kubernetes" {
  instance = "${aws_instance.kubernetes.id}"
  vpc      = true
}

resource "null_resource" "connect_kubernetes" {
  connection {
    host        = "${aws_eip.kubernetes.public_ip}"
    type	= "ssh"
    user        = "ubuntu"
    private_key = "${file("kube_key")}"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt-get -y install python"]
  }
  
  provisioner "local-exec" {
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./kube_key -i '${aws_eip.kubernetes.public_ip},' kube.yml"
  }
  
 provisioner "local-exec" {
        command = <<EOF
      rm -rf $HOME/.kube;
      scp -r -i kube_key ubuntu@"${aws_eip.kubernetes.public_ip}":/home/ubuntu/.kube $HOME/
      EOF
     
  }
  depends_on = ["aws_eip.kubernetes"]
}
