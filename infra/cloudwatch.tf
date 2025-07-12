resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name              = "/ecs/${aws_ecs_cluster.ecs-cluster.name}"
  retention_in_days = 3
}

