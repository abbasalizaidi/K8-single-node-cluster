output "public-ip" {
  value = "${aws_eip.kubernetes.public_ip}"
}
