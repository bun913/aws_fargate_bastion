resource "aws_security_group" "db" {
  name        = "${var.prefix}-db-sg"
  description = "Allow Inbound From App"
  vpc_id      = var.vpc_id
  ingress {
    description = "MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [
      var.bastion_sg_id
    ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
