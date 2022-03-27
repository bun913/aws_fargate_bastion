#/bin/bash
ENVIRONMENT=$1
if [ -z "${ENVIRONMENT}" ]; then
  echo "第1引数に環境名を指定してください"
  exit 1
fi
TASK_ID=$2
PROJECT="fargate-bastion"
BASE_NAME="${PROJECT}-${ENVIRONMENT}"
CLUSTER_NAME="${BASE_NAME}-bastion-cluster"
aws ecs execute-command --cluster ${CLUSTER_NAME} \
--task ${TASK_ID} \
--container "bastion" \
--interactive \
--command "/bin/sh"