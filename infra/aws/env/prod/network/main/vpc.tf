resource "aws_vpc" "this" {
    cidr_block                       = "172.35.0.0/16"
    enable_dns_hostnames             = true
    enable_dns_support               = true

    tags                             = {
        "Name" = "minoru-saito-vpc"
    }
}
