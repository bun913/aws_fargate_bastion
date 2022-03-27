output "rds_cluster_endpoint" {
  value = aws_rds_cluster.main.endpoint
}
output "rds_reader_endpoint" {
  value = aws_rds_cluster.main.reader_endpoint
}
