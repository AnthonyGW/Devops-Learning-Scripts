resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
}

resource "aws_eip" "forNat" {
  vpc = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_network_acl" "all" {
  vpc_id = "${aws_vpc.main.id}"

  egress {
    protocol   = "-1"
    rule_no    = 2
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 1
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "open acl"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "172.31.0.0/20"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags {
    Name = "PublicSN"
  }

  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "172.31.16.0/20"
  availability_zone       = "us-east-1d"
  map_public_ip_on_launch = false

  tags {
    Name = "PrivateSN"
  }

  depends_on = ["aws_internet_gateway.gw"]
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "${aws_eip.forNat.id}"
  subnet_id     = "${aws_subnet.public_subnet.id}"
  depends_on    = ["aws_internet_gateway.gw"]
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "public_rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "private_rt"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.nat_gw.id}"
  }
}

resource "aws_route_table_association" "PublicA" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "PrivateA" {
  subnet_id      = "${aws_subnet.private_subnet.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
