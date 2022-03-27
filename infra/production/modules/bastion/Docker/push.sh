#!/bin/bash -e
PROJECT=$1
if [ -z "${PROJECT}" ]; then
  echo "第1引数にプロジェクト名を指定してください"
  exit 1
fi
AWS_ACCOUNT_ID=$2
INIT_TAG=prd
ECR_BASE_URI=${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com
ECR_PREFIX=${ECR_BASE_URI}/${PROJECT}
# ログイン
aws ecr get-login-password --region ap-northeast-1 | \
 docker login --username AWS --password-stdin ${ECR_BASE_URI}
# build
IMAGE_FULL_NAME="${ECR_PREFIX}-bastion"
# cd mysql_connector
docker build --platform linux/amd64 -t ${IMAGE_FULL_NAME}:${INIT_TAG} ./
docker push ${IMAGE_FULL_NAME}:${INIT_TAG}
