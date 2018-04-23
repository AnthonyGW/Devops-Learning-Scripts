resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_subnet" "main_subnet" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "172.31.0.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "Main"
  }

  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_eip" "socks_frontend" {
  vpc = true

  instance                  = "${aws_instance.socks_front.id}"
  associate_with_private_ip = "${aws_instance.socks_front.private_ip}"
  depends_on                = ["aws_internet_gateway.gw"]
}

resource "aws_eip" "socks_catalogue" {
  vpc = true

  instance                  = "${aws_instance.socks_catalogue.id}"
  associate_with_private_ip = "${aws_instance.socks_catalogue.private_ip}"
  depends_on                = ["aws_internet_gateway.gw"]
}
