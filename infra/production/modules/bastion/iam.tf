# ECSタスク実行ロール
resource "aws_iam_role" "bastion_task_exec_role" {
  name               = "${var.prefix}-bastion-task-execution"
  assume_role_policy = file("${path.module}/iam/ecs_assume_policy.json")
}

# TODO: タスク実行ロールの権限を最小にする
data "aws_iam_policy" "ecs_task_exec" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
# CloudWatchLogの権限もタスク実行ロールに与える
data "aws_iam_policy" "cloudwatch" {
  arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "bastion_task_exec_role" {
  role       = aws_iam_role.bastion_task_exec_role.name
  policy_arn = data.aws_iam_policy.ecs_task_exec.arn
}


resource "aws_iam_role_policy_attachment" "ecs_task_exec_logs" {
  role       = aws_iam_role.bastion_task_exec_role.name
  policy_arn = data.aws_iam_policy.cloudwatch.arn
}
# タスクロールを作成する(ECS Exec実行等)
resource "aws_iam_role" "ecs_task" {
  name               = "${var.prefix}-ecs-task"
  assume_role_policy = file("${path.module}/iam/ecs_assume_policy.json")
}

resource "aws_iam_role_policy" "ecs_exec" {
  name = "${var.prefix}-ecs-task"
  role = aws_iam_role.ecs_task.id

  policy = file("${path.module}/iam/ecs_task_role_policy.json")
}
