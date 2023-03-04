# ECRからimage pull
resource "aws_vpc_endpoint" "ecr-dkr" {
  vpc_id            = var.vpc_id
  service_name = "com.amazonaws.${local.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  security_group_ids = var.security_group_ids
  subnet_ids = [
    "subnet-0ab533658301117d7"
  ]
  private_dns_enabled = true
  tags = {
    Name = "minoru-com.amazonaws.${local.region}.ecr.dkr-endpoint"
  }
}

resource "aws_vpc_endpoint" "ecr-api" {
  vpc_id            = var.vpc_id
  service_name = "com.amazonaws.${local.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  security_group_ids = var.security_group_ids
  subnet_ids = [
    "subnet-0ab533658301117d7"
  ]
  private_dns_enabled = true
  tags = {
    Name = "minoru-com.amazonaws.${local.region}.ecr.api-endpoint"
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc_id
  service_name = "com.amazonaws.${local.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [
    "rtb-0d0891d1a0cc821f5"
  ]
  tags = {
    Name = "minoru-com.amazonaws.${local.region}.s3-endpoint"
  }
}

# awslogsログドライバーを使用したECSタスク→cloudwatchのログ送信
resource "aws_vpc_endpoint" "logs" {
  vpc_id            = var.vpc_id
  service_name = "com.amazonaws.${local.region}.logs"
  vpc_endpoint_type = "Interface"
  security_group_ids = var.security_group_ids
  subnet_ids = [
    "subnet-0ab533658301117d7"
  ]
  private_dns_enabled = true
  tags = {
    Name = "minoru-com.amazonaws.${local.region}.logs-endpoint"
  }
}

# Systems Managerのパラメータストアから値を取得
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = var.vpc_id
  service_name = "com.amazonaws.${local.region}.ssm"
  vpc_endpoint_type = "Interface"
  security_group_ids = var.security_group_ids
  subnet_ids = [
    "subnet-0ab533658301117d7"
  ]
  private_dns_enabled = true
  tags = {
    Name = "minoru-com.amazonaws.${local.region}.ssm-endpoint"
  }
}

# use ECS Exec
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = var.vpc_id
  service_name = "com.amazonaws.${local.region}.ssmmessages"
  vpc_endpoint_type = "Interface"
  security_group_ids = var.security_group_ids
  subnet_ids = [
    "subnet-0ab533658301117d7"
  ]
  private_dns_enabled = true
  tags = {
    Name = "minoru-com.amazonaws.${local.region}.ssmmessages-endpoint"
  }
}
