## CloudWatch Logs
resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.app_name}/ecs-agent"
}

resource "aws_cloudwatch_log_group" "app" {
  name = "${var.app_name}/docker-containers"
}
