resource "aws_subnet" "public_a" {
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "172.35.1.0/24" # minoru-saito-public-a
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.this.id

  tags = {
    Name = "minoru-saito-public-a"
  }
}

resource "aws_subnet" "public_c" {
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "172.35.2.0/24"  # minoru-saito-public-c
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.this.id

  tags = {
    Name = "minoru-saito-public-c"
  }
}


resource "aws_subnet" "private_a" {
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "172.35.5.0/24" # minoru-saito-private-later-1
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.this.id

  tags = {
    Name = "minoru-saito-private-later-1"
  }
}

resource "aws_subnet" "private_c" {
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "172.35.15.0/24" # minoru-saito-private-3
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.this.id

  tags = {
    Name = "minoru-saito-private-3"
  }
}

