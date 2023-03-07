output "general_lambda_arn" {
  value = one(aws_lambda_function.general_lambda[*].arn)
}

output "vpc_lambda_arn" {
  value = one(aws_lambda_function.vpc_lambda[*].arn)
}

output "general_lambda_name" {
  value = one(aws_lambda_function.general_lambda[*].function_name)
}

output "vpc_lambda_name" {
  value = one(aws_lambda_function.vpc_lambda[*].function_name)
}
