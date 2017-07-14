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

variable "ecs_cluster_name" {
  description = "The name of the cluster in ECS."
}

variable "ecs_service_name" {
  description = "The name of the service in the ECS cluster, usually the same as the app name."
}

variable "ecs_docker_image" {
  description = "The docker image, and version for the task definition. e.g. postgres:latest"
}

variable "ecs_container_name" {
  description = "The name to give the container that is accessible via the load balancer, usually the same as the app name."
}

variable "ecs_container_port_number" {
  description = "The port number of the container that is accessible via the load balancer."
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