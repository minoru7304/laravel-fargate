
terraform {
  backend "s3" {
    bucket = "minoru-terraform"
    key    = "example/prod/notice/foobar_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
