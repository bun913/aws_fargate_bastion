variable "prefix" {
  type        = string
  description = "Default Prefix of Resource Name"
}
variable "region" {
  type        = string
  description = "Region for bastion"
}
variable "vpc_id" {
  type = string
}
variable "ecr_base_uri" {
  type = string
}
variable "db_subnet_cidrs" {
  type        = list(string)
  description = "DB Subnets CidrBloks"
}
variable "tags" {
  type = object({
    Environment = string
    Project     = string
    Terraform   = string
  })
}

