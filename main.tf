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
  
  #https://eu-west-1.console.aws.amazon.com/ec2/v2/home?region=eu-west-1#LoadBalancers:
  # Optional variables
  # instance_ami = ""
  instance_type = "m4.large"
  # asg_min = ""
  # asg_max = ""
  # asg_desired = ""
  # admin_cidr_ingress = ""
}