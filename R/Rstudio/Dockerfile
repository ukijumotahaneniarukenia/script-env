FROM centos:latest

#rstudioユーザー追加＆serenaグループ追加
#rstudioのユーザーidとグループidは1001でないとダメ絶対
RUN yum install -y sudo
RUN groupadd -g 1001 serena
RUN useradd -m -g serena -u 1001 rstudio
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'root_pwd' | passwd --stdin root
RUN echo '%docker ALL=(ALL)       ALL' >> /etc/sudoers
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#実行ユーザをrstudioに変更
USER rstudio

#epelレポからRインストール
RUN sudo yum install -y epel-release
RUN sudo yum install -y R

#Rstudioインストール
RUN sudo yum install -y --nogpgcheck https://download2.rstudio.org/rstudio-server-rhel-1.0.44-x86_64.rpm

#諸々インストール
#ネットワーク系は必須
RUN sudo yum install -y pandoc
RUN sudo yum install -y nkf
RUN sudo yum install -y iputils
RUN sudo yum install -y net-tools
RUN sudo yum install -y iproute
RUN sudo yum install -y vim
RUN sudo yum install -y tree
RUN sudo yum install -y lsof
RUN sudo yum install -y traceroute
RUN sudo yum install -y psmisc
RUN sudo yum install -y bind-utils
RUN sudo yum install -y git
RUN sudo yum install -y make
RUN sudo yum install -y expect
RUN sudo yum install -y openssh-server
RUN sudo yum install -y openssh-clients
RUN sudo yum install -y gcc

#実行ユーザをrootに変更
USER root

#Tukubaiコマンドは便利
RUN git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make install

#awkコマンドは最新の奴 include使える
RUN curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make && \
make install

#bashも最新
RUN curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
tar -zxvf bash-5.0.tar.gz && \
cd bash-5.0 && \
./configure && \
make && \
make install

#vimも最新
RUN git clone https://github.com/vim/vim.git && \
yum install -y ncurses-devel && \
cd vim && \
make distclean && \
make && \
make install

#pythonもそこそこ最新
RUN yum install -y python36 python36-devel python36-libs && \
python3 -m ensurepip && \
pip3 install --upgrade pip

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#alias設定
RUN echo alias python="/usr/bin/python3.6" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip" >> ~/.bashrc

#Rstudioサービスの提供ポートを外部アクセスようにオープンしておく
EXPOSE 8787

#コンテナログイン時のwdを設定
WORKDIR /home/rstudio

CMD ["/sbin/init"]
