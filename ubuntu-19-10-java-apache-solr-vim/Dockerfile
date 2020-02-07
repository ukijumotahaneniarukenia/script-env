FROM ubuntu:19.10

#対話入力無視
ARG DEBIAN_FRONTEND=noninteractive

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt update && apt upgrade -y

RUN apt install -y systemd vim apt-utils lsof sudo

#ユーザー作成
RUN groupadd -g 1001 solr && \
useradd -m -g solr -u 1001 solr && \
echo 'solr:solr_pwd' | chpasswd && \
echo 'solr ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash solr

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

#javaコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && \
tar xvf openjdk-11+28_linux-x64_bin.tar.gz

#apache-solrインストール
RUN cd /usr/local/src && \
curl -LO http://ftp.jaist.ac.jp/pub/apache/lucene/solr/8.4.1/solr-8.4.1.tgz && \
tar xvf solr-8.4.1.tgz && \
chown -R solr:solr solr-8.4.1

#環境変数の設定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'export JAVA_HOME=/usr/local/src/jdk-11' >> ~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$PATH' >>~/.bashrc && \
echo 'export APACHE_SOLR_HOME=/usr/local/src/solr-8.4.1' >>~/.bashrc && \
echo 'export PATH=$APACHE_SOLR_HOME/bin:$PATH' >>~/.bashrc

USER solr

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
echo 'export JAVA_HOME=/usr/local/src/jdk-11' >> ~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$PATH' >>~/.bashrc && \
echo 'export APACHE_SOLR_HOME=/usr/local/src/solr-8.4.1' >>~/.bashrc && \
echo 'export PATH=$APACHE_SOLR_HOME/bin:$PATH' >>~/.bashrc

#apache-solrサービス外部公開ポート
EXPOSE 8983

WORKDIR /home/solr
