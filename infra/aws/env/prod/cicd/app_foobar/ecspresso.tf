// referenced by ecspresso

data "aws_cloudwatch_log_group" "nginx" {
  name = "/ecs/${local.name_prefix}-${local.service_name}/nginx"
}

data "aws_cloudwatch_log_group" "php" {
  name = "/ecs/${local.name_prefix}-${local.service_name}/php"
}

data "aws_ecr_repository" "nginx" {
  name = "${local.name_prefix}-${local.service_name}-nginx"
}

data "aws_ecr_repository" "php" {
  name = "${local.name_prefix}-${local.service_name}-php"
}

data "aws_iam_role" "ecs_task_execution" {
  name = "${local.name_prefix}-${local.service_name}-ecs-task-execution"
}

data "aws_iam_role" "ecs_task" {
  name = "${local.name_prefix}-${local.service_name}-ecs-task"
}

data "aws_lb_target_group" "this" {
  name = "${local.name_prefix}-${local.service_name}"
}

data "aws_security_group" "cache_foobar" {
  name = "minoru-cache-foobar"
}

data "aws_security_group" "db_foobar" {
  name = "minoru-db-foobar"
}

data "aws_security_group" "vpc" {
  name = "minoru-vpc"
}

data "aws_subnet" "private" {
  for_each = var.azs

  tags = {
    Name = "minoru-saito-private-later-1"
  }
}

data "aws_s3_bucket" "env_file" {
  bucket = "minoru-${local.name_prefix}-${local.service_name}-env-file"
}

variable "azs" {
  type = map(object({
    public_cidr  = string
    private_cidr = string
  }))
  default = {
    a = {
      public_cidr  = "172.35.1.0/24"  # minoru-saito-public-a
      private_cidr = "172.35.5.0/24"  # minoru-saito-private-later-1
    },
    c = {
      public_cidr  = "172.35.2.0/24"  # minoru-saito-public-c
      private_cidr = "172.35.15.0/24" # minoru-saito-private-3
    }
  }
}


