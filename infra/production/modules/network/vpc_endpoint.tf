# TODO: VPCエンドポイントのIAMロールを最小限に見直し
data "aws_iam_policy_document" "vpc_endpoint" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}
# Interface endpoint
resource "aws_vpc_endpoint" "interface" {
  for_each     = toset(var.interface_services)
  vpc_id       = aws_vpc.main.id
  service_name = each.value
  subnet_ids = [
    for sb in aws_subnet.private : sb.id
  ]
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.interface_vpc_endpointd.id]
  policy              = data.aws_iam_policy_document.vpc_endpoint.json
  private_dns_enabled = true
}
