terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.8.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
  default_tags {
    tags = {
      "Project"     = "fargate-bastion"
      "Environment" = "prd"
      "Terraform"   = "true"
    }
  }
}

data "aws_caller_identity" "current" {}

locals {
  default_prefix = "${var.tags.Project}-${var.tags.Environment}"
  ecr_base_uri   = "${data.aws_caller_identity.current.account_id}.dkr.ecr.ap-northeast-1.amazonaws.com"
}

module "network" {
  source = "./modules/network/"

  prefix             = local.default_prefix
  vpc_cidr           = var.vpc_cidr
  private_subnets    = var.private_subnets
  db_subnets         = var.db_subnets
  interface_services = var.vpc_endpoint.interface

  tags = var.tags
}

module "bastion" {
  source = "./modules/bastion/"

  prefix = local.default_prefix
}

# module "database" {
#   source = "./modules/database/"

#   prefix     = local.default_prefix
#   vpc_id     = module.network.vpc_id
#   subnet_ids = module.network.db_subnet_ids
#   app_sg_id  = module.web_app.ecs_service_sg_id
#   /* bastion_sg_id = module.bastion.bastion_sg_id */

#   az_names = [for sb in var.db_subnets : sb.az]

#   tags = var.tags
# }
