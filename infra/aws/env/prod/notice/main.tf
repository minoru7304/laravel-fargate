# eventbridge
resource "aws_cloudwatch_event_rule" "get_rds_record_rule" {
  name        = "minoru_get_rds_record"
  schedule_expression = "cron(00 1 ? * MON-FRI *)" # 平日の10:00
}

resource "aws_cloudwatch_event_target" "get_rds_record_target" {
  rule      = aws_cloudwatch_event_rule.get_rds_record_rule.name
  target_id = "minoru_get_rds_record"
  arn       = module.minoru_get_rds_record.vpc_lambda_arn
}

resource "aws_lambda_permission" "allow_get_rds_record" {
  statement_id  = "allow_execute_get_rds_record_lambda"
  action        = "lambda:InvokeFunction"
  function_name = module.minoru_get_rds_record.vpc_lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.get_rds_record_rule.arn
}

# SNS
resource "aws_sns_topic" "notice_slack" {
  name = "minoru_notice_slack"
}

resource "aws_sns_topic_subscription" "lambda" {
  topic_arn = aws_sns_topic.notice_slack.arn
  protocol  = "lambda"
  endpoint  = module.minoru_notice_slack.general_lambda_arn
}

resource "aws_lambda_permission" "allow_notice_slack" {
  statement_id  = "allow_execute_notice_slack_lambda"
  action        = "lambda:InvokeFunction"
  function_name = module.minoru_notice_slack.general_lambda_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.notice_slack.arn
}

# lambda
module "minoru_get_rds_record" {
    source = "../../../module/lambda"
    select_flag = 2
    function_name = "minoru_get_rds_record"
    function_role = data.terraform_remote_state.app.outputs.iam_role_notice_slack_arn
    security_group_ids = [
        data.terraform_remote_state.network_main.outputs.security_group_execute_rds_lambda_id
        ]
}

module "minoru_notice_slack" {
    source = "../../../module/lambda"
    select_flag = 1
    function_name = "minoru_notice_slack"
    function_role = data.terraform_remote_state.app.outputs.iam_role_notice_slack_arn
    security_group_ids = []
}


