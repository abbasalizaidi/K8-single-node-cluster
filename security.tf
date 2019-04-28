resource "aws_security_group" "kube_security" {

  description = "Kubernetes security group."

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 6443
    to_port = 6443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }

  vpc_id = "${aws_vpc.kubernetes-vpc.id}"
}

resource "aws_key_pair" "kube_keypair" {
  key_name = "kube_keypair"
  public_key = "${file("kube_key.pub")}"
}
