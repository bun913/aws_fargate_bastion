resource "aws_security_group" "interface_vpc_endpointd" {
  name        = "${var.prefix}-interface-engpoint-sg"
  description = "Allow HTTPS inbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Inbound from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
}
