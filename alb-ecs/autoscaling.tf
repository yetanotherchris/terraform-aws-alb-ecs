### Compute
resource "aws_autoscaling_group" "containers_asg" {
  name                 = "${var.app_name}-asg"
  vpc_zone_identifier  = ["${var.aws_subnet_a_id}"]
  min_size             = "${var.autoscale_min}"
  max_size             = "${var.autoscale_max}"
  desired_capacity     = "${var.autoscale_desired}"
  launch_configuration = "${aws_launch_configuration.containers_launchconfig.name}"
}

resource "aws_launch_configuration" "containers_launchconfig" {
  security_groups = [
    "${aws_security_group.instance_sg.id}",
  ]

  key_name             = "${var.key_name}"
  image_id             = "${var.instance_ami}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.name}"

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
