
output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs-cluster.arn
}
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.ecs-task.arn
}
output "ecs_service_arn" {
  value = aws_ecs_service.ecs-service.arn
}
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}
output "ecs_log_group_arn" {
  value = aws_cloudwatch_log_group.ecs-log-group.arn
}
output "ecs_task_execution_role_policy_attachment" {
  value = aws_iam_role_policy_attachment.ecs_task_execution_role_policy.id
}
output "ecs_security_group_arn" {
  value = aws_security_group.ecs-sg.arn
}
# output "alb_target_group_arn" {
#   value = aws_lb_target_group.app.arn
# }
# output "alb_listener_arn" {
#   value = aws_lb_listener.http.arn
# }

# output "load_balancer_dns_name" {
#   value = aws_lb.app.dns_name
# }