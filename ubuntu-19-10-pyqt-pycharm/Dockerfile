FROM ubuntu:19.10

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y

#各種コマンドないしライブラリインストール
RUN apt-get install -y vim gcc make lsb-release wget gnupg sudo && \
apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev && \
apt-get install -y libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev wget libgl1-mesa-dev

#tclコマンドいんすこ
RUN cd /usr/local/src && curl -LO https://prdownloads.sourceforge.net/tcl/tcl8.6.10-src.tar.gz && \
tar xvf tcl8.6.10-src.tar.gz && \
cd tcl8.6.10 && \
cd unix && \
export CFLAGS=-DTCL_UTF_MAX=6 && \
export MAKEFLAGS=-j5 && \
./configure --prefix=/usr/local --enable-threads --enable-shared --enable-symbols --enable-64bit --enable-langinfo --enable-man-symlinks && \
make -j12 && \
make -j12 install

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
RUN echo 'alias pyc="bash /usr/local/src/pycharm-community-2019.3.1/bin/pycharm.sh 1>~/launch_pycharm.log 2>&1 &"' >>~/.bashrc && \
echo 'alias qtd="( mkdir -p $HOME/qt-wrksp && export XDG_RUNTIME_DIR=$HOME/qt-wrksp && cd /usr/lib/x86_64-linux-gnu/qt5/bin && ./designer 1>~/launch_qt_designer.log 2>&1 </dev/null & )"' >>~/.bashrc

USER kuraine

#環境変数の設定
RUN echo 'alias pyc="bash /usr/local/src/pycharm-community-2019.3.1/bin/pycharm.sh 1>~/launch_pycharm.log 2>&1 &"' >>~/.bashrc && \
echo 'alias qtd="( mkdir -p $HOME/qt-wrksp && export XDG_RUNTIME_DIR=$HOME/qt-wrksp && cd /usr/lib/x86_64-linux-gnu/qt5/bin && ./designer 1>~/launch_qt_designer.log 2>&1 </dev/null & )"' >>~/.bashrc

WORKDIR /home/kuraine
