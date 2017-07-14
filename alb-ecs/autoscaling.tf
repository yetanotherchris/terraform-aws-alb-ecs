### Compute
resource "aws_autoscaling_group" "app" {
  name                 = "${var.app_name}-asg"
  vpc_zone_identifier  = ["${var.aws_subnet_a_id}"]
  min_size             = "${var.asg_min}"
  max_size             = "${var.asg_max}"
  desired_capacity     = "${var.asg_desired}"
  launch_configuration = "${aws_launch_configuration.app.name}"
}

resource "aws_launch_configuration" "app" {
  security_groups = [
    "${aws_security_group.instance_sg.id}",
  ]

  key_name             = "${var.key_name}"
  image_id             = "${var.instance_ami}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.app.name}"

  user_data = <<EOF
#!/bin/bash
sudo yum update -y ecs-init
echo "ECS_CLUSTER=${aws_ecs_cluster.main.name}" >> /etc/ecs/ecs.config
sudo service docker restart && sudo start ecs

EOF

  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}
