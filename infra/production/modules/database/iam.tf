data "aws_iam_policy_document" "db_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "db_monitor" {
  name               = "${var.prefix}-db-monitoring-role"
  path               = "/rds/"
  assume_role_policy = data.aws_iam_policy_document.db_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "db_monitor" {
  role = aws_iam_role.db_monitor.name
  # NOTE: 管理ポリシーを利用
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
