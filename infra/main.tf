provider "aws" {
  region = var.aws_region
}

# module "vpc" {
#   source = "./modules"
# }

# module "ecs" {
#   source = "./ecs"
#   vpc_id             = module.vpc.vpc_id
#   public_subnet_ids  = module.vpc.public_subnet_ids
#   cluster_name       = var.ecs_cluster_name
# }
