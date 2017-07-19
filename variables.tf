# Required variables to pass into the alb-ecs module. 

# These are are duplicate variables from the module due to the way Terraform works.
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

variable "sg_loadbalancer_cidrs" {
  description = "CIDR to allow port 80 ingress traffic to the load balancer."
  type        = "list"
}

variable "sg_ec2_instance_cidrs" {
  description = "CIDR to allow tcp/22 ingress to the EC2 instances in the autoscaling group."
  type        = "list"
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

# See the alb-ecs/variables.tf file for all the optional variables