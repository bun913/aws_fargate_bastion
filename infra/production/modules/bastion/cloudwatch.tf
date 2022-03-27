resource "aws_cloudwatch_log_group" "bastion" {
  name              = "/ecs/${var.prefix}-bastion"
  retention_in_days = 1
}
