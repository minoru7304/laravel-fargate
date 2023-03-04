# resource "aws_route_table" "private" {
#   for_each = var.azs

#   vpc_id = "vpc-0be7eabe7f291ec71"

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
