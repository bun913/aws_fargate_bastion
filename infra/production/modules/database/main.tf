resource "aws_db_subnet_group" "main" {
  name       = "${var.prefix}-db-subnet-group"
  subnet_ids = var.subnet_ids
}

# rds cluster group
resource "aws_rds_cluster" "main" {
  cluster_identifier              = "${var.prefix}-db-cluster"
  engine                          = "aurora-mysql"
  engine_version                  = "8.0.mysql_aurora.3.01.0"
  availability_zones              = var.az_names
  database_name                   = "mysqlDB"
  enabled_cloudwatch_logs_exports = ["audit", "error", "slowquery"]
  master_username                 = "root"
  # TODO: 実際の運用ではダミーパスワードの変更が必要
  master_password                     = "Dummy!Password"
  iam_database_authentication_enabled = true
  apply_immediately                   = true
  # NOTE: バックアップ保持期間。要件に応じて値を変更すること
  backup_retention_period         = 2
  db_subnet_group_name            = aws_db_subnet_group.main.id
  vpc_security_group_ids          = [aws_security_group.db.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.main.id
  # TODO: デモ用のため削除保護をfalseにしている。本番では必ず設定する
  deletion_protection = false
  skip_final_snapshot = true

  lifecycle {
    ignore_changes = [
      availability_zones,
      master_password
    ]
  }
}

# rds_instance
resource "aws_rds_cluster_instance" "main" {
  count              = 2
  cluster_identifier = aws_rds_cluster.main.id
  identifier         = "${aws_rds_cluster.main.id}-${count.index}"
  engine             = aws_rds_cluster.main.engine
  engine_version     = aws_rds_cluster.main.engine_version
  # NOTE: 要件に応じてインスタンスクラスを調整すること
  instance_class          = "db.t3.medium"
  db_subnet_group_name    = aws_db_subnet_group.main.name
  db_parameter_group_name = aws_db_parameter_group.main.name

  # 拡張モニタリング
  monitoring_role_arn = aws_iam_role.db_monitor.arn
  monitoring_interval = 60

  publicly_accessible = false
}
