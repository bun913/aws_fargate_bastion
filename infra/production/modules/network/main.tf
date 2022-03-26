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
