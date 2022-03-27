data "aws_caller_identity" "current" {}

# 初回イメージプッシュのみTerraformで実行
resource "null_resource" "bastion_push_image" {

  provisioner "local-exec" {
    working_dir = "${path.module}/Docker"
    # 第１引数にProject名、第2引数にアカウントIDを渡す
    command = "./push.sh ${var.tags.Project} ${data.aws_caller_identity.current.account_id}"
  }

}
