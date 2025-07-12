variable "project_name" {
  type        = string
  description = "The name of the project."
  default     = "ecs-automated-testing" # Default project name can be overridden in terraform.tfvars
}
variable "aws_region" {
  type        = string
  description = "The AWS region where the ECS cluster will be deployed."
  default     = "us-east-1" # Default region can be overridden in terraform.tfvars
}

variable "ecs_cluster_name" {
  type        = string
  description = "The name of the ECS cluster."
  default     = "auto-test-fargate-cluster" # Default cluster name can be overridden in terraform.tfvars
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the ECS cluster will be deployed."
}

variable "subnets" {
  type        = list(string)
  description = "The IDs of the subnets where the ECS tasks will be deployed."
  # overridden in terraform.tfvars

}

variable "security_groups" {
  type        = list(string)
  description = "The IDs of the security groups to associate with the ECS tasks."
  # overridden in terraform.tfvars
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "The IDs of the public subnets where the ECS tasks will be deployed."
}

variable "nginx_containerPort" {
  type = number
  # Ensure the port is a valid number between 1 and 65535
  validation {
    condition     = var.nginx_containerPort > 0 && var.nginx_containerPort <= 65535
    error_message = "nginx_containerPort must be a valid port number between 1 and 65535."
  }
  description = "The container port for the Nginx container."
  default     = 80
}

variable "nginx_hostPort" {
  type = number
  validation {
    condition     = var.nginx_hostPort > 0 && var.nginx_hostPort <= 65535
    error_message = "nginx_hostPort must be a valid port number between 1 and 65535."
  }
  description = "The host port for the Nginx container."
  default     = 80
}

variable "nginx_protocol" {
  type        = string
  description = "The protocol for the Nginx container."
  default     = "tcp"
}