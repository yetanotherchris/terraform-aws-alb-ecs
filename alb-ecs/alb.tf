## ALB

resource "aws_alb_target_group" "target_group" {
  name     = "${var.app_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws_vpc_id}"
}

resource "aws_alb" "main" {
  name            = "${var.app_name}"
  subnets         = ["${var.aws_subnet_a_id}", "${var.aws_subnet_b_id}"]
  security_groups = ["${aws_security_group.lb_sg.id}"]
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = "${aws_alb.main.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    type             = "forward"
  }
}
