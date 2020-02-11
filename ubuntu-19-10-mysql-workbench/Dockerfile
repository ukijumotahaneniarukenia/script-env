FROM ubuntu:19.10

ARG CONTAINER_NAME
ARG OS_VERSION
ARG GIT_VERSION
ARG PYTHON_VERSION
ARG JAVA_VERSION
ARG MYSQL_WORKBENCH_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN groupadd -g 1001 mysql && \
useradd -m -g mysql -u 1001 mysql && \
chsh -s /bin/bash mysql && \
echo 'mysql_pwd' | passwd --stdin mysql && \
echo 'mysql ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo 'root_pwd' | passwd --stdin root

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

RUN apt install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-jdk-$JAVA_VERSION.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

#mysql-workbenchインストール
COPY mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb /usr/local/src/mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-mysql-workbench-$MYSQL_WORKBENCH_VERSION.sh | bash

#XクライアントがXサーバーにGUI転送出来るように、転送先の「IP:ディスプレイ番号:スクリーン番号」を指定する
ENV DISPLAY=:0.0

USER mysql
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

WORKDIR /home/mysql
