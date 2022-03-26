variable "prefix" {
  type        = string
  description = "Default Prefix of Resource Name"
}
variable "region" {
  type        = string
  description = "Region for bastion"
}
variable "ecr_base_uri" {
  type = string
}
variable "tags" {
  type = object({
    Environment = string
    Project     = string
    Terraform   = string
  })
}

