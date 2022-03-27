resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "db" {
  for_each          = { for sb in var.db_subnets : sb.name => sb }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, { "Name" : "${var.prefix}-${each.value.name}" })
}

resource "aws_subnet" "private" {
  for_each          = { for sb in var.private_subnets : sb.name => sb }
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = merge(var.tags, { "Name" : "${var.prefix}-${each.value.name}" })
}

# NATゲートウェイなしでECSを利用する場合にS3のエンドポイントが必要
# プライベートサブネット用ルートテーブル
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags   = merge({ "Name" : "${var.prefix}--route-private" }, var.tags)
}

# RouteTableAssociation for pribate
resource "aws_route_table_association" "private" {
  for_each       = { for sb in var.private_subnets : sb.name => sb }
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}
