resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.project_name}_cluster"
}

resource "aws_ecs_task_definition" "ecs-task" {
  family                   = "${var.project_name}_task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "web",
      image     = "nginx:latest",
      cpu       = 256,
      memory    = 512,
      essential = true,
      portMappings = [
        {
          containerPort = var.nginx_containerPort,
          hostPort      = var.nginx_hostPort,
          protocol      = var.nginx_protocol
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs-log-group.name,
          awslogs-region        = var.aws_region,
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
resource "aws_ecs_service" "ecs-service" {
  name            = "${var.project_name}_ecs-service"
  cluster         = aws_ecs_cluster.ecs-cluster.id
  task_definition = aws_ecs_task_definition.ecs-task.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    subnets          = var.subnets
    security_groups  = var.security_groups
    assign_public_ip = true
  }
}


# resource "aws_ecs_service" "app" {
#   name            = "sample-service"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.app.arn
#   desired_count   = 1
#   launch_type     = "FARGATE"

#   network_configuration {
#     subnets         = var.public_subnet_ids
#     assign_public_ip = true
#     security_groups  = [aws_security_group.ecs.id]
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.app.arn
#     container_name   = "web"
#     container_port   = 80
#   }

#   depends_on = [aws_lb_listener.http]
# }

# resource "aws_security_group" "ecs" {
#   name        = "ecs-sg"
#   description = "Allow HTTP traffic"
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
