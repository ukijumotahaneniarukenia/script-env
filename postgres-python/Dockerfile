FROM ubuntu:16.04

RUN apt-get update && \
apt-get -y upgrade && \
apt-get install -y vim gcc make && \
apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev

#pythonコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar xvf Python-3.7.4.tgz && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

#ユーザー単位でダイナミックリンクライブラリファイルのフォルダ指定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && . ~/.bashrc

#ライブラリキャッシュファイルの更新
RUN echo '/usr/local/lib'>>/etc/ld.so.conf.d/local-ld.so.conf
RUN ldconfig

#postgresコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://ftp.postgresql.org/pub/source/v12.0/postgresql-12.0.tar.gz && \
tar xvf postgresql-12.0.tar.gz && \
chown -R root:root postgresql-12.0 && \
cd postgresql-12.0 && \
./configure --prefix=/usr/local --libdir=/usr/local/lib/postgresql --with-python && \
make -j12 && \
make -j12 install

#ユーザー作成
RUN groupadd -g 1001 postgres && \
useradd -m -g postgres -u 1001 postgres && \
echo 'postgres:postgres_pwd' | chpasswd && \
echo 'postgres ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash postgres

RUN echo 'root:root_pwd' | chpasswd

USER postgres

#ユーザー単位でダイナミックリンクライブラリファイルのフォルダ指定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && . ~/.bashrc

WORKDIR /home/postgres
