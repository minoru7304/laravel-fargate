resource "aws_elasticache_subnet_group" "this" {
  name = "minoru"

  subnet_ids = [
    "subnet-0ab533658301117d7", # minoru-saito-private-later-1 1a
    "subnet-0085c60e0ac02551a"  # minoru-saito-private-3 1c
  ]
}
