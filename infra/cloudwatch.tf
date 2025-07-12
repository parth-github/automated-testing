resource "aws_kms_key" "cloudwatch_logs" {
  description = "KMS key for CloudWatch Logs encryption"
}

resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name              = "/ecs/${aws_ecs_cluster.ecs-cluster.name}"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.cloudwatch_logs.arn
}

