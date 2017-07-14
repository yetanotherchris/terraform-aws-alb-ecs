# Variables used by the alb-ecs module.

# Required variables
variable "aws_region" {
  description = "The AWS region to create things in."
}

variable "aws_vpc_id" {
  description = "The id of the VPC to attach the resources to."
}

variable "aws_subnet_a_id" {
  description = "The first subnet id inside the VPC."
}

variable "aws_subnet_b_id" {
  description = "The second subnet id inside the VPC."
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

# Optional variables
variable "instance_ami" {
  default     = "ami-809f84e6"
  description = "The AMI id of the ECS-optimised image. See http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "AWS instance type"
}

variable "asg_min" {
  description = "Min numbers of servers in ASG"
  default     = "1"
}

variable "asg_max" {
  description = "Max numbers of servers in ASG"
  default     = "2"
}

variable "asg_desired" {
  description = "Desired numbers of servers in ASG"
  default     = "1"
}