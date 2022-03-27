vpc_cidr = "10.12.0.0/16"

private_subnets = [
  {
    "name" : "fargate-bastion-private-a",
    "az" : "ap-northeast-1a",
    "cidr" : "10.12.10.0/24"
  },
  {
    "name" : "fargate-bastion-private-c",
    "az" : "ap-northeast-1c",
    "cidr" : "10.12.11.0/24"
  },
]

db_subnets = [
  {
    "name" : "fargate-bastion-db-a",
    "az" : "ap-northeast-1a",
    "cidr" : "10.12.20.0/24"
  },
  {
    "name" : "fargate-bastion-db-c",
    "az" : "ap-northeast-1c",
    "cidr" : "10.12.21.0/24"
  },
]

vpc_endpoint = {
  "interface" : [
    # ECSからECRにイメージをpullするため
    "com.amazonaws.ap-northeast-1.ecr.dkr",
    "com.amazonaws.ap-northeast-1.ecr.api",
    # CloudWatchLogsにログ出力のため
    "com.amazonaws.ap-northeast-1.logs",
    # SSM SessionManagerで接続するため
    "com.amazonaws.ap-northeast-1.ssmmessages",
    "com.amazonaws.ap-northeast-1.ssm",
    # SecretManagerから環境変数を取得するため
    # "com.amazonaws.ap-northeast-1.secretsmanager"
  ],
  "gateway" : [
    # ECSに必要
    "com.amazonaws.ap-northeast-1.s3"
  ]
}
