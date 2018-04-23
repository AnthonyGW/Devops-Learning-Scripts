# export an extracted AMI ID from the manifest into TF_VAR_ami_frontend e.g $ export TF_VAR_ami_frontend="ami-0a112a9470ff50a55"
resource "aws_instance" "socks_front" {
  ami                    = "${var.ami_frontend}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.main_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags {
    Name = "socks_front"
  }
}

# export an extracted AMI ID from the manifest into TF_VAR_ami_catalogue e.g $ export TF_VAR_ami_catalogue="ami-09c6c70b4adf26b4d"
resource "aws_instance" "socks_catalogue" {
  ami                    = "${var.ami_catalogue}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.main_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags = {
    Name = "socks_catalogue"
  }
}

output "socks_front_ip" {
  value = "${aws_instance.socks_front.public_dns}"
}

output "socks_catalogue_ip" {
  value = "${aws_instance.socks_catalogue.public_dns}"
}
