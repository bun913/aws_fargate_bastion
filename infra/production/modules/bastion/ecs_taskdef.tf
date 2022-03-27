# 今回アプリケーションは作成しないのでBastion用にクラスターを作成する
resource "aws_ecs_cluster" "bastion" {
  name = "${var.prefix}-bastion-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "app" {
  family        = "${var.prefix}-task-def"
  task_role_arn = aws_iam_role.ecs_task.arn
  network_mode  = "awsvpc"
  requires_compatibilities = [
    "FARGATE"
  ]
  execution_role_arn = aws_iam_role.bastion_task_exec_role.arn
  memory             = "512"
  cpu                = "256"
  container_definitions = templatefile(
    "${path.module}/taskdef/taskdef.json",
    {
      IMAGE_PREFIX      = "${var.ecr_base_uri}/${var.tags.Project}"
      BASTION_LOG_GROUP = aws_cloudwatch_log_group.bastion.name
      REGION            = var.region
    }
  )
}
