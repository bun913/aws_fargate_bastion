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

# s3 endpoint
resource "aws_vpc_endpoint" "gateway" {
  for_each          = toset(var.gateway_services)
  vpc_id            = aws_vpc.main.id
  service_name      = each.value
  policy            = data.aws_iam_policy_document.vpc_endpoint.json
  vpc_endpoint_type = "Gateway"
}
# gateway endpoint route table assosiation
resource "aws_vpc_endpoint_route_table_association" "s3_route_ass" {
  for_each        = toset(var.gateway_services)
  vpc_endpoint_id = aws_vpc_endpoint.gateway[each.value].id
  route_table_id  = aws_route_table.private.id
}
