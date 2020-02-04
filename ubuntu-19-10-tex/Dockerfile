FROM ubuntu:19.10

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt-get install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh

#各種コマンドないしライブラリインストール
RUN apt-get install -y vim gcc make lsb-release wget gnupg sudo && \
apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev && \
apt-get install -y libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev wget libgl1-mesa-dev

#texコマンドインストール
RUN apt -y install texlive-full

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
echo 'kuraine:kuraine_pwd' | chpasswd && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash kuraine

RUN echo 'root:root_pwd' | chpasswd

#日本語環境と時刻合わせ
ENV LANG=ja_JP.UTF-8

USER kuraine

WORKDIR /home/kuraine
