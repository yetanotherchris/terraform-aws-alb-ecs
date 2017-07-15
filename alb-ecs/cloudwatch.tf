## CloudWatch Logs
resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.app_name}/ecs-agent"
}

resource "aws_cloudwatch_log_group" "containers" {
  name = "${var.app_name}/containers"
}
