data "archive_file" "function_zip" {
    type = "zip"
    source_dir = "../../../module/lambda/src/${var.function_name}"
    output_path = "../../../module/lambda/zipfile/${var.function_name}.zip"
}

# lambda
resource "aws_lambda_function" "general_lambda" {
  count = var.select_flag == 1? 1:0
  filename      = data.archive_file.function_zip.output_path
  function_name = var.function_name
  role          = var.function_role
  runtime       = "python3.8"
  handler = "${var.function_name}.lambda_handler"
  timeout       = 300
  source_code_hash = data.archive_file.function_zip.output_base64sha256
}

# VPC内lambda
resource "aws_lambda_function" "vpc_lambda" {
  count = var.select_flag == 2? 1:0
  filename      = data.archive_file.function_zip.output_path
  function_name = var.function_name
  role          = var.function_role
  runtime       = "python3.8"
  handler = "${var.function_name}.lambda_handler"
  timeout       = 300
  source_code_hash = data.archive_file.function_zip.output_base64sha256

  vpc_config {
    subnet_ids         = [
    "subnet-0ab533658301117d7",
    "subnet-0085c60e0ac02551a"
  ]
    security_group_ids = var.security_group_ids
  }
}
