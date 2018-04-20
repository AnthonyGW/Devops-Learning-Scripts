variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "ami_frontend" {}
variable "ami_catalogue" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# export an extracted AMI ID from the manifest into TF_VAR_ami_frontend e.g $ export TF_VAR_ami_frontend="ami-0a112a9470ff50a55"
resource "aws_instance" "socks_front" {
  ami           = "${var.ami_frontend}"
  instance_type = "t2.micro"
}

# export an extracted AMI ID from the manifest into TF_VAR_ami_catalogue e.g $ export TF_VAR_ami_catalogue="ami-09c6c70b4adf26b4d"
resource "aws_instance" "socks_catalogue" {
  ami           = "${var.ami_catalogue}"
  instance_type = "t2.micro"
}

# get elastic ip for lb
# provision a vpc in two zones with subnets
# provision an application load balancer pointing to them
# set up target groups
# set up listener (endpoint rules for '/' and '/catalogue')

