FROM ubuntu:18.04

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt-get install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh

#各種コマンドないしライブラリインストール
RUN apt-get install -y vim gcc make lsb-release wget gnupg sudo sqlite3 libsqlite3-dev && \
apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev && \
apt-get install -y libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev wget libgl1-mesa-dev

#pythonコマンドいんすこ
RUN cd /usr/local/src && \
curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
cd Python-3.7.4 && \
./configure && \
make -j12 && \
make -j12 install

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
echo 'kuraine:kuraine_pwd' | chpasswd && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash kuraine

RUN echo 'root:root_pwd' | chpasswd

#X環境インストール
RUN apt-get install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#Pycharmインストール
COPY pycharm-community-2019.3.1.tar.gz  /usr/local/src/pycharm-community-2019.3.1.tar.gz
RUN cd /usr/local/src && tar xvf pycharm-community-2019.3.1.tar.gz

#環境変数の設定
RUN echo 'alias pyc="bash /usr/local/src/pycharm-community-2019.3.1/bin/pycharm.sh 1>~/launch_pycharm.log 2>&1 &"' >>~/.bashrc

USER kuraine

#環境変数の設定
RUN echo 'alias pyc="bash /usr/local/src/pycharm-community-2019.3.1/bin/pycharm.sh 1>~/launch_pycharm.log 2>&1 &"' >>~/.bashrc

#日本語環境と時刻合わせ
ENV LANG=ja_JP.UTF-8

USER kuraine

#httpdサービス外部公開ポート
EXPOSE 8000

WORKDIR /home/kuraine
