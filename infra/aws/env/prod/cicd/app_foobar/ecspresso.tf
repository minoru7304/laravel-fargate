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

data "aws_security_group" "vpc" {
  name = "minoru-vpc"
}

data "aws_subnet" "private" {
  for_each = var.azs

  tags = {
    Name = "minoru-saito-private-later-1"
  }
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
    # c = {
    #   public_cidr  = "172.32.16.0/20"
    #   private_cidr = "172.32.64.0/20"
    # }
  }
}


