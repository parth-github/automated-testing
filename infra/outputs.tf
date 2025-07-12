output "load_balancer_dns_name" {
  value = aws_lb.app.dns_name
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}
output "ecs_service_name" {
  value = aws_ecs_service.app.name
}
output "ecs_task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}
output "ecs_security_group_id" {
  value = aws_security_group.ecs.id
}
# output "alb_target_group_arn" {
#   value = aws_lb_target_group.app.arn
# }
output "alb_listener_arn" {
  value = aws_lb_listener.http.arn
}
output "ecs_task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}