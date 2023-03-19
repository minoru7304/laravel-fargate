# resource "aws_route_table" "private" {
#   for_each = var.azs

#   vpc_id = aws_vpc.this.id

#   tags = {
#     Name = "minoru-private-${each.key}"
#   }
# }

# resource "aws_route" "nat_gateway_private" {
#   for_each = var.enable_nat_gateway ? var.azs : {}

#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.this[var.single_nat_gateway ? keys(var.azs)[0] : each.key].id
#   route_table_id         = aws_route_table.private[each.key].id
# }

# resource "aws_route_table_association" "private" {
#   for_each = var.azs

#   route_table_id = aws_route_table.private[each.key].id
#   subnet_id      = "subnet-0ab533658301117d7"
# }

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "minoru-saito-rtb-later"
  }
}

resource "aws_route" "internet_gateway_public" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  route_table_id         = aws_route_table.public.id
}

resource "aws_route_table_association" "a" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_a.id
}

resource "aws_route_table_association" "c" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public_c.id
}
