variable "prefix" {
  type        = string
  description = "common prefix for all resources"
}
variable "tags" {
  type = object({
    Project   = string
    Terraform = string
  })
}
