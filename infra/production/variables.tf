variable "region" {
  type    = string
  default = "ap-northeast-1"
}
variable "vpc_cidr" {
  type        = string
  description = "Main VPC CidrBlock"
}
variable "db_subnets" {
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
  description = "Private Subnets For RDS"
}
variable "private_subnets" {
  type = list(object({
    name = string
    az   = string
    cidr = string
  }))
  description = "Private Subnets For Bastion"
}
variable "vpc_endpoint" {
  # TODO: 型を丁寧に書く
  type        = map(any)
  description = "vpc_endpoint_setting"
}
variable "tags" {
  type = map(string)
  default = {
    "Project"     = "fargate-bastion"
    "Environment" = "prd"
    "Terraform"   = "true"
  }
}
