module "nginx" {
    source = "../../../../module/ecr"

    name = "${local.name_prefix}-${local.service_name}-nginx"
}

module "php" {
    source = "../../../../module/ecr"

    name = "${local.name_prefix}-${local.service_name}-php"
}
