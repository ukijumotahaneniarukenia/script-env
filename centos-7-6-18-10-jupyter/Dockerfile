FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#各種コマンドいんすこ
RUN yum -y install epel-release
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which perl-Digest-SHA lbzip gcc-c++ libtool makeinfo file libffi-devel zlib-devel unzip autoconf gcc bison

#pythonコマンドいんすこ
RUN cd /usr/local/src && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
chown -R root:root Python-3.7.4 && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

RUN echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
source ~/.bashrc

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#X環境周りいんすこ
#各種X関連コマンドインストール
RUN yum install -y xeyes xorg-x11-server-utils xterm xorg-x11-apps firefox

#Xwindowシステムパッケージいんすこ
RUN yum groupinstall -y base "X Window System" --setopt=group_package_types=mandatory,default,optional

#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#入力メソッドいんすこ
RUN yum install -y ibus-mozc

USER kuraine

RUN echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
source ~/.bashrc

#jupyterサービス外部公開ポート
EXPOSE 8888

WORKDIR /home/kuraine
#コンテナ起動後実行
#RUN pip3 install numpy pandas matplotlib seaborn scikit-learn plotly ipython[notebook]
