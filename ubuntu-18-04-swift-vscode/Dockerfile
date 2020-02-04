FROM ubuntu:18.04

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
RUN apt install -y vim gcc make lsb-release wget gnupg sudo sqlite3 libsqlite3-dev && \
apt install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev && \
apt install -y libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev wget libgl1-mesa-dev

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
echo 'kuraine:kuraine_pwd' | chpasswd && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash kuraine

RUN echo 'root:root_pwd' | chpasswd

#X環境インストール
RUN apt install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#swiftインストール
RUN apt install -y clang libicu-dev
RUN cd /usr/local/src && \
curl -LO https://swift.org/builds/development/ubuntu1804/swift-DEVELOPMENT-SNAPSHOT-2020-01-31-a/swift-DEVELOPMENT-SNAPSHOT-2020-01-31-a-ubuntu18.04.tar.gz && \
tar xvf swift-DEVELOPMENT-SNAPSHOT-2020-01-31-a-ubuntu18.04.tar.gz

#VSCODEいんすこ
RUN apt install -y libnotify4 libxkbfile1 libxss1 libsecret-1-0 libasound2
COPY code_1.41.1-1576681836_amd64.deb /usr/local/src/code_1.41.1-1576681836_amd64.deb
RUN cd /usr/local/src && dpkg -i code_1.41.1-1576681836_amd64.deb

#環境変数の設定
RUN echo 'export SWIFT_HOME=/usr/local/src/swift-DEVELOPMENT-SNAPSHOT-2020-01-31-a-ubuntu18.04/usr' >>~/.bashrc && \
echo 'export PATH=$SWIFT_HOME/bin:$PATH' >>~/.bashrc

USER kuraine

#日本語環境と時刻合わせ
ENV LANG=ja_JP.UTF-8

#環境変数の設定
RUN echo 'export SWIFT_HOME=/usr/local/src/swift-DEVELOPMENT-SNAPSHOT-2020-01-31-a-ubuntu18.04/usr' >>~/.bashrc && \
echo 'export PATH=$SWIFT_HOME/bin:$PATH' >>~/.bashrc

WORKDIR /home/kuraine
