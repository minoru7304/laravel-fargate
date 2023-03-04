module "vpc_endpoint" {
  source = "../../../../module/vpc_endpoint"

  vpc_id = "vpc-0be7eabe7f291ec71"
  security_group_ids = [
    aws_security_group.vpc_endpoint.id
  ]
}
