## ALB
## The auto-scaling group is linked to the ALB via 
# the ALB's target_group_arns property.

output "loadbalancer_url" {
  value = "${aws_alb.alb.dns_name}"
}

resource "aws_alb_target_group" "target_group" {
  name     = "${var.app_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws_vpc_id}"

  health_check {
    port = "${var.ecs_container_port_number}",
    unhealthy_threshold = 3
  }
}

resource "aws_alb" "alb" {
  name            = "${var.app_name}"
  subnets         = ["${var.aws_subnet_a_id}", "${var.aws_subnet_b_id}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]

  idle_timeout = 3600
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = "${aws_alb.alb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }
}
