variable "prefix" {
  type        = string
  description = "Default Prefix of Resource Name"
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
variable "gateway_services" {
  type        = list(string)
  description = "VPCエンドポイントのサービス名のリスト(ゲートウェイ型)"
}
variable "interface_services" {
  type        = list(string)
  description = "VPCエンドポイントのサービス名のリスト(インターフェース型)"
}
variable "tags" {
  type = object({
    Environment = string
    Project     = string
    Terraform   = string
  })
}
