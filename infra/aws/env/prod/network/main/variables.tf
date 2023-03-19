variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "vpc_cidr" {
  type    = string
  default = "172.35.0.0/16"
}

# variable "azs" {
#   type = map(object({
#     public_cidr  = string
#     private_cidr = string
#   }))
#   default = {
#     a = {
#       public_cidr  = "172.35.1.0/24" # minoru-saito-public-a
#       private_cidr = "172.35.5.0/24" # minoru-saito-private-later-1
#     },
#     c = {
#       public_cidr  = "172.35.2.0/24"  # minoru-saito-public-c
#       private_cidr = "172.35.15.0/24" # minoru-saito-private-3
#     }
#   }
# }

data "aws_region" "current" {}
