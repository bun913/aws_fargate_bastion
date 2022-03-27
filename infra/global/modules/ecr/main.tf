resource "aws_ecr_repository" "bastion" {
  name                 = "${var.prefix}-bastion"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
