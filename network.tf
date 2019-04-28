resource "aws_vpc" "kubernetes-vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_subnet" "kube_subnet" {
  vpc_id            = "${aws_vpc.kubernetes-vpc.id}"
  cidr_block        = "172.16.10.0/24"
  availability_zone = "${var.availability_zone_id}"

  tags = {
    Name = "kubernetes"
  }
}

resource "aws_route_table" "route-table-kube" {
  vpc_id = "${aws_vpc.kubernetes-vpc.id}"
route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kube-gw.id}"
  }
tags {
    Name = "Kubernetes"
  }
}

resource "aws_route_table_association" "kube-subnet-association" {
  subnet_id      = "${aws_subnet.kube_subnet.id}"
  route_table_id = "${aws_route_table.route-table-kube.id}"
}

resource "aws_internet_gateway" "kube-gw" {
  vpc_id = "${aws_vpc.kubernetes-vpc.id}"
}
