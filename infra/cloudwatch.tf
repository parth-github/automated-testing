resource "aws_kms_key" "cloudwatch_logs" {
  description         = "KMS key for CloudWatch Logs encryption"
  enable_key_rotation = true

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Id": "cloudwatch-logs-kms-policy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.aws_account_id}:role/ecsTaskExecutionRole"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "ecs-log-group" {
  name              = "/ecs/${aws_ecs_cluster.ecs-cluster.name}"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.cloudwatch_logs.arn
}

