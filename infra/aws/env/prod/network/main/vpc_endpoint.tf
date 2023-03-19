module "vpc_endpoint" {
  source = "../../../../module/vpc_endpoint"

  vpc_id = aws_vpc.this.id
  security_group_ids = [
    aws_security_group.vpc_endpoint.id
  ]
}
