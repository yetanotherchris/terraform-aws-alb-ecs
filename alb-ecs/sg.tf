### Security

resource "aws_security_group" "lb_sg" {
  name   = "${var.app_name}-loadbalancer"
  vpc_id = "${var.aws_vpc_id}"
  description = "Controls access to the ELB infront of ECS"

  tags {
    Name = "${var.app_name}-loadbalancer"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [ "0.0.0.0/0"]
  }
}

resource "aws_security_group" "instance_sg" {
  name        = "${var.app_name}-ec2-instances"
  vpc_id      = "${var.aws_vpc_id}"
  description = "Controls direct access to the EC2 instances in the auto scaling group"

  tags {
    Name = "${var.app_name}-ec2instance"
  }

  ingress {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22

    cidr_blocks = [
      "${var.sg_ec2_instance_cidr}",
    ]
  }

  ingress {
    protocol  = "tcp"
    from_port = "${var.ecs_container_port_number}"
    to_port   = "${var.ecs_container_port_number}"

    security_groups = [
      "${aws_security_group.lb_sg.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
