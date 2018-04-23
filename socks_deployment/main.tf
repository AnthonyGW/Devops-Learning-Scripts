provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

# get elastic ip for lb
# provision a vpc in two zones with subnets
# provision an application load balancer pointing to them
# set up target groups
# set up listener (endpoint rules for '/' and '/catalogue')

