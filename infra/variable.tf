variable "aws_region" {
  default = "us-east-1"
}

variable "ecs_cluster_name" {
  default = "fargate-cluster"
}

variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
