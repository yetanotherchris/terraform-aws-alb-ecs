# Specify the provider and access details
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

#data "aws_availability_zones" "available" {}

module "ecs" {
  source = "alb-ecs/"

  # These values come from the tfvars file
  aws_region         = "${var.aws_region}"
  aws_vpc_id         = "${var.aws_vpc_id}"
  aws_subnet_a_id    = "${var.aws_subnet_a_id}"
  aws_subnet_b_id    = "${var.aws_subnet_b_id}"
  admin_cidr_ingress = "${var.admin_cidr_ingress}"
  key_name           = "${var.key_name}"
  app_name           = "${var.app_name}"
  
  # Optional variables
  # instance_ami = ""
  instance_type = "t2.nano"
  asg_min = "3"
  asg_max = "6"
  asg_desired = "3"
  # admin_cidr_ingress = ""
}