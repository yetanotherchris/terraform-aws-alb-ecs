## ECS
resource "aws_ecs_cluster" "main" {
  name = "${var.ecs_cluster_name}"
}

data "template_file" "task_definition_template" {
  template = "${file("${path.module}/task-definition.json")}"

  vars {
    image_url        = "${var.ecs_docker_image}"
    container_name   = "${var.ecs_container_name}"
    log_group_region = "${var.aws_region}"
    log_group_name   = "${aws_cloudwatch_log_group.app.name}"
  }
}

resource "aws_ecs_task_definition" "task_def" {
  family                = "${var.ecs_container_name}"
  container_definitions = "${data.template_file.task_definition_template.rendered}"
}

resource "aws_ecs_service" "service" {
  name            = "${var.ecs_service_name}"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.task_def.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.ecs_service.name}"

  load_balancer {
    target_group_arn = "${aws_alb_target_group.target_group.id}"
    container_name   = "${var.ecs_container_name}"
    container_port   = "${var.ecs_container_port_number}"
  }

  depends_on = [
    "aws_iam_role_policy.ecs_service",
    "aws_alb_listener.front_end",
  ]
}