variable "tags" {
  type = map(string)
  default = {
    "Project"   = "fargate-bastion"
    "Terraform" = "true"
  }
}
