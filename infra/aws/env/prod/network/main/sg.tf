resource "aws_security_group" "web" {
  name   = "minoru-web"
  vpc_id = "vpc-0be7eabe7f291ec71"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minoru-web"
  }
}

resource "aws_security_group" "vpc" {
  name   = "minoru-vpc"
  vpc_id = "vpc-0be7eabe7f291ec71"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minoru-vpc"
  }
}

resource "aws_security_group" "db_foobar" {
  name   = "minoru-db-foobar"
  vpc_id = "vpc-0be7eabe7f291ec71"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minoru-db-foobar"
  }
}

resource "aws_security_group" "cache_foobar" {
  name   = "minoru-cache-foobar"
  vpc_id = "vpc-0be7eabe7f291ec71"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minoru-cache-foobar"
  }
}


resource "aws_security_group" "vpc_endpoint" {
  name        = "minoru-vpc_endpoint-sg"
  description = "minoru-vpc_endpoint-sg"
  vpc_id      = "vpc-0be7eabe7f291ec71"

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.35.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minoru-vpc_endpoint-sg"
  }
}
