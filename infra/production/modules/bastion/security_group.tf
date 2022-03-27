resource "aws_security_group" "bastion" {
  name        = "${var.prefix}-bastion"
  description = "Egress TO DB"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
