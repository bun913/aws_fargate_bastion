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
      "Project"   = "fargate-bastion"
      "Terraform" = "true"
    }
  }
}

locals {
  default_prefix = var.tags.Project
}

module "ecr" {
  source = "./modules/ecr/"

  prefix = local.default_prefix
  tags   = var.tags
}
