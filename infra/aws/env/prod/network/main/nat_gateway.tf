resource "aws_nat_gateway" "this" {
  for_each = var.enable_nat_gateway ? local.nat_gateway_azs : {}

  allocation_id = aws_eip.nat_gateway[each.key].id
  subnet_id     = "subnet-0fea4f842edfc355f"

  tags = {
    Name = "minoru-${each.key}"
  }
}
