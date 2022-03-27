#/bin/bash
ENVIRONMENT=$1
if [ -z "${ENVIRONMENT}" ]; then
  echo "第1引数に環境名を指定してください"
  exit 1
fi
PROJECT="fargate-bastion"
BASE_NAME="${PROJECT}-${ENVIRONMENT}"
# 最新のタスク定義を取得
TASK_DEF=$(aws ecs list-task-definitions --status active --query "sort(taskDefinitionArns[?contains(@, '${BASE_NAME}')])"  | jq -r  'sort | reverse[0]' )
# サブネットを取得
SUBNET_ID=$( aws ec2 describe-subnets --query "Subnets" --filters "Name=tag:Name,Values='${BASE_NAME}-fargate-bastion-private-a'" | jq -r  '.[0].SubnetId')
SG_ID=$(aws ec2 describe-security-groups --query "SecurityGroups[].GroupId"  --filters "Name=tag:Project,Values='${PROJECT}'" "Name=group-name,Values=${BASE_NAME}-bastion" --output text)
NETWORK_CONFIG="awsvpcConfiguration={subnets=[${SUBNET_ID}],securityGroups=[${SG_ID}],assignPublicIp=ENABLED}"
aws ecs run-task --cluster "${BASE_NAME}-bastion-cluster" \
--enable-execute-command \
--task-definition "${TASK_DEF}" \
--network-configuration "${NETWORK_CONFIG}" \
--launch-type FARGATE \
--query "tasks[0].taskArn" --output text \
| awk '{count = split($1, arr, "/"); print arr[count]}'
