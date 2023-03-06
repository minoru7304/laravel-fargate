data "terraform_remote_state" "app" {
  backend = "s3"

  config = {
    bucket = "minoru-terraform"
    key    = "${local.system_name}/${local.env_name}/app/foobar_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}

data "terraform_remote_state" "network_main" {
  backend = "s3"

  config = {
    bucket = "minoru-terraform"
    key    = "${local.system_name}/${local.env_name}/network/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
