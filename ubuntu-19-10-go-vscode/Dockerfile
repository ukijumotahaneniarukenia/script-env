FROM ubuntu:19.10

#対話入力無視
ARG DEBIAN_FRONTEND=noninteractive

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt update && apt upgrade -y

RUN apt install -y systemd vim apt-utils

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
echo 'kuraine:kuraine_pwd' | chpasswd && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash kuraine

RUN echo 'root:root_pwd' | chpasswd

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh
ENV LANG=ja_JP.UTF-8

#X環境インストール
RUN apt install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#VSCODEいんすこ
RUN apt install -y libnotify4 libxkbfile1 libxss1 libsecret-1-0 libasound2 gnupg
COPY code_1.41.1-1576681836_amd64.deb /usr/local/src/code_1.41.1-1576681836_amd64.deb
RUN cd /usr/local/src && dpkg -i code_1.41.1-1576681836_amd64.deb

#vimインストール
RUN apt install -y git curl wget
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#dotfileインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
mv rc/.[^.]* ~ && \
rm -rf ~/tmp
#ライブラリ管理dein.vimインストール
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
cd ~ && sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#goいんすこ
RUN apt install -y gcc
RUN cd /usr/local/src && \
curl -LO https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz && \
cd /usr/local/src && \
curl -LO https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
cd /usr/local/src && mkdir -p go1.4 && \
cd /usr/local/src && tar xvf go1.4.3.linux-amd64.tar.gz && \
cd /usr/local/src && mv /usr/local/src/go/* go1.4 && \
cd /usr/local/src && tar xvf go1.13.5.linux-amd64.tar.gz && \
cd go/src && export GOROOT_BOOTSTRAP=/usr/local/src/go1.4 && ./all.bash

#環境変数の設定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'export GOROOT=/usr/local/src/go'>>~/.bashrc && \
echo 'export PATH=$GOROOT/bin:$PATH'>>~/.bashrc

USER kuraine

#vimインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#dotfileインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
mv rc/.[^.]* ~ && \
rm -rf ~/tmp
#ライブラリ管理dein.vimインストール
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
cd ~ && sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#環境変数
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'export GOROOT=/usr/local/src/go'>>~/.bashrc && \
echo 'export PATH=$GOROOT/bin:$PATH'>>~/.bashrc

WORKDIR /home/kuraine
