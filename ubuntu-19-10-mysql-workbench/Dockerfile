FROM ubuntu:19.10

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

#対話入力無視
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

RUN apt install -y systemd

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh
ENV LANG=ja_JP.UTF-8

#各種コマンドないしライブラリインストール
RUN apt install -y vim gcc make lsb-release wget gnupg sudo && \
apt install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev && \
apt install -y libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev wget libgl1-mesa-dev

#javaコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz && \
tar -zxvf openjdk-13_linux-x64_bin.tar.gz

#ユーザー作成
RUN groupadd -g 1001 mysql && \
useradd -m -g mysql -u 1001 mysql && \
echo 'mysql:mysql_pwd' | chpasswd && \
echo 'mysql ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash mysql

RUN echo 'root:root_pwd' | chpasswd

#環境変数の設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'alias myb="mysql-workbench 1>~/launch_mysql-bench.log 2>&1 &"' >>~/.bashrc

#mysql workbenchいんすこ
ENV NO_AT_BRIDGE=1
COPY mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb /usr/local/src/mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb
RUN apt install -y libquazip5-dev libsigc++-2.0-dev libpcrecpp0v5 libmysqlclient21 libgtk2.0-dev libglibmm-2.4-dev libatkmm-1.6-dev libxml2-dev libsecret-1-dev libpangocairo-1.0-0 libgdk-pixbuf2.0-dev libcairo2-dev libgtk-3-dev libgtkmm-3.0-dev python2.7-dev libquazip5-dev libzip5 packagekit-gtk3-module canberra-gtk* libproj-dev proj-bin
RUN cd /usr/local/src && dpkg -i mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb

#mysqlいんすこ
#コンテナ起動後、行う
#RUN cd /usr/local/src && curl -o mysql.deb https://repo.mysql.com/mysql-apt-config_0.8.14-1_all.deb && \
#export DEBIAN_FRONTEND=noninteractive && dpkg -i mysql.deb && \
#apt install -y mysql-server

#X環境インストール
RUN apt-get install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#VSCODEいんすこ
RUN apt install -y libnotify4 libxkbfile1 libxss1
COPY code_1.41.1-1576681836_amd64.deb /usr/local/src/code_1.41.1-1576681836_amd64.deb
RUN cd /usr/local/src && dpkg -i code_1.41.1-1576681836_amd64.deb

USER mysql

#環境変数の設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'alias myb="mysql-workbench 1>~/launch_mysql-bench.log 2>&1 &"' >>~/.bashrc

WORKDIR /home/mysql
