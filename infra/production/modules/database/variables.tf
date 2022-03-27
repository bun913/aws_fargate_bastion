variable "prefix" {
  type        = string
  description = "Default Prefix of Resource Name"
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type        = list(string)
  description = "DB Subnet ID List"
}
variable "bastion_sg_id" {
  type        = string
  description = "Allow SG of Bastion"
}
variable "db_family" {
  type        = string
  description = "RDS DB Family"
  default     = "aurora-mysql8.0"
}
variable "az_names" {
  type        = list(string)
  description = "AZ for RDS Cluster"
}
variable "tags" {
  type = object({
    Environment = string
    Project     = string
    Terraform   = string
  })
}
