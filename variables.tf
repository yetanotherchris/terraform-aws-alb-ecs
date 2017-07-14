# Required variables to pass into the alb-ecs module. These are
# are duplicate variable names due to the way Terraform works.
#
# The values can be declared in a terraform.tfvars file.

variable "aws_access_key" {
  description = ""
}

variable "aws_secret_key" {
  description = ""
}

variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "aws_vpc_id" {
  description = ""
}

variable "aws_subnet_a_id" {
  description = ""
}

variable "aws_subnet_b_id" {
  description = ""
}

variable "admin_cidr_ingress" {
  description = "CIDR to allow tcp/22 ingress to EC2 instance"
}

variable "key_name" {
  description = "The SSH key name to access the EC2 instances in the cluster"
}

variable "app_name" {
  description = "The name of this application, e.g. My-Ghost."
}