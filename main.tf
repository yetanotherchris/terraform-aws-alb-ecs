provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

output "docker_repository" {
  value = "${module.ecs.repository}"
}

output "loadbalancer_url" {
  value = "http://${module.ecs.loadbalancer_url}"
}

module "ecs" {
  source = "alb-ecs/"

  # These values come from the .tfvars file, or the command line
  aws_region         = "${var.aws_region}"
  aws_vpc_id         = "${var.aws_vpc_id}"
  aws_subnet_a_id    = "${var.aws_subnet_a_id}"
  aws_subnet_b_id    = "${var.aws_subnet_b_id}"

  sg_ec2_instance_cidr = "${var.sg_ec2_instance_cidr}"
  sg_loadbalancer_cidr = "${var.sg_loadbalancer_cidr}"
  key_name           = "${var.key_name}"
  app_name           = "${var.app_name}"

  ecs_cluster_name = "${var.ecs_cluster_name}"
  ecs_service_name = "${var.ecs_service_name}"
  ecs_docker_image = "${var.ecs_docker_image}"
  ecs_container_name = "${var.ecs_container_name}"
  ecs_container_port_number = "${var.ecs_container_port_number}"
  
  # Optional variables
  instance_type = "t2.nano"
  autoscale_min = "3"
  autoscale_max = "6"
  autoscale_desired = "3"
}