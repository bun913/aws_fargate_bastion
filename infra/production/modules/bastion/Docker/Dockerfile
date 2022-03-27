FROM amazonlinux:2
# MySQLの新しいGPGキーをインストールする
RUN rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022 && \
    yum install -y sudo jq awscli shadow-utils htop lsof telnet bind-utils yum-utils && \
    yum install -y yum localinstall https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm && \
    yum-config-manager --disable mysql80-community && \
    yum-config-manager --enable mysql57-community && \
    yum install -y mysql-community-client
