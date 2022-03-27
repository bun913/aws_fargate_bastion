output "db_subnet_ids" {
  value = [
    for sb in aws_subnet.db : sb.id
  ]
}

output "private_subnet_ids" {
  value = [
    for sb in aws_subnet.private : sb.id
  ]
}

output "vpc_id" {
  value = aws_vpc.main.id
}
