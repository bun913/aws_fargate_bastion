# FargateによるBastion(踏み台ホスト)の構築

## 　構成

今回は ECS FargateでAmazonLinuxベースのイメージを用意して、ECS Execで接続します。

通常ECSのコンテナ環境に接続する方法として、ECS Execが利用できます。

https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/userguide/ecs-exec.html

今回は、以下の理由によりあえてセッションマネージャーを利用しています。

- RDSで稼働しているMySQLに TablePlusなどのDBクライアント経由で接続したかった
  - ECS Execだとsshトンネリングチックな接続が出来るか調べてもわからなかった
  - 頑張ればできそうではある・・・

## 手順

### 事前準備

### globalリソース群の作成

今回はECRを作成して、イメージのプッシュまで行う。

```bash
cd infra/global
terraform init
terraform plan
terraform apply
```

### productionリソース群の作成

今回は本番環境を想定して、productionというディレクトリ名にしている。
（他、developmentやstagingなど環境ごとに作成されるイメージ)


```bash
cd ../production
terraform init
terraform plan
terraform apply
```

## ローカルからの実行

```bash
# タスクをCLIで起動
 ./run_task.sh prd
# task_idが出力されればOK
# 出力されたタスクIDを第2引数に渡す
./ecs_exec.sh prd ${TASKのID}
```