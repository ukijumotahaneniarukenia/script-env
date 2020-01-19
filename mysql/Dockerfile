FROM ubuntu:19.10

#レポジトリを日本サーバーの一つに変更
#RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y vim gcc make lsb-release wget gnupg sudo && \
apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev

#ユーザー作成
RUN groupadd -g 1001 mysql && \
useradd -m -g mysql -u 1001 mysql && \
echo 'mysql:mysql_pwd' | chpasswd && \
echo 'mysql ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash mysql

RUN echo 'root:root_pwd' | chpasswd

#X環境インストール
RUN apt-get install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#VScodeインストール
COPY code_1.41.1-1576681836_amd64.deb /usr/local/src/code_1.41.1-1576681836_amd64.deb
