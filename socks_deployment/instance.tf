resource "aws_instance" "socks_front" {
  ami                    = "${var.ami_frontend}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.private_subnet.id}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${aws_security_group.allow_internal_traffic.id}", "${aws_security_group.allow_ssh.id}"]

  tags {
    Name = "socks_front"
  }
}

resource "aws_instance" "socks_catalogue" {
  ami                    = "${var.ami_catalogue}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.private_subnet.id}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${aws_security_group.allow_internal_traffic.id}", "${aws_security_group.allow_ssh.id}"]

  tags = {
    Name = "socks_catalogue"
  }
}

resource "aws_instance" "nginx_lb" {
  ami                    = "${var.ami_catalogue}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public_subnet.id}"
  key_name               = "${var.aws_keyname}"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}", "${aws_security_group.allow_internal_traffic.id}", "${aws_security_group.allow_ssh.id}"]

  tags = {
    Name = "nginx_lb"
  }
}

output "loadbalancer public_ip" {
  value = "${aws_instance.nginx_lb.public_ip}"
}
