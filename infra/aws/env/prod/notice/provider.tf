provider "aws" {
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Env            = "prod"
      System         = "example"
      CmBillingGroup = "minoru-saito"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.42.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.1"
    }
  }

  required_version = "1.0.0"
}
