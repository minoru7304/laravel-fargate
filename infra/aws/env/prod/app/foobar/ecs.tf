resource "aws_ecs_cluster" "this" {
  name = "${local.name_prefix}-${local.service_name}"

  capacity_providers = [
    "FARGATE",
    "FARGATE_SPOT"
  ]

  tags = {
    Name = "${local.name_prefix}-${local.service_name}"
  }
}

resource "aws_appautoscaling_target" "ecsfargate" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.this.name}/example-prod-foobar"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = 2
  max_capacity       = 4
}

resource "aws_appautoscaling_policy" "ecsfargate_scale_out" {
  name               = "scale_out"
  policy_type        = "TargetTrackingScaling"
  service_namespace  = aws_appautoscaling_target.ecsfargate.service_namespace
  resource_id        = aws_appautoscaling_target.ecsfargate.resource_id
  scalable_dimension = aws_appautoscaling_target.ecsfargate.scalable_dimension

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    target_value = 40.0
  }
}
