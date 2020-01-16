FROM centos/systemd

#ユーザー作成
RUN groupadd -g 1001 postgres && \
useradd -m -g postgres -u 1001 postgres && \
chsh -s /bin/bash postgres && \
echo 'postgres_pwd' | passwd --stdin postgres && \
echo 'postgres ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#各種コマンドいんすこ
RUN yum -y install epel-release
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which perl-Digest-SHA lbzip gcc-c++ libtool makeinfo file libffi-devel zlib-devel unzip autoconf gcc bison evince

#vimも最新
RUN yum install -y sudo gcc git gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
cd ~ && git clone https://github.com/vim/vim.git && \
cd vim && \
./configure --enable-multibyte --with-features=huge --enable-cscope --enable-gui=gtk2 --disable-selinux --prefix=/usr/local --enable-xim --enable-fontset --enable-gpm --enable-rubyinterp --with-python-config-dir=/usr/lib/python2.7/config && \
make -j12 distclean && \
make -j12 && \
make -j12 install && \
ln -fsr /usr/local/bin/vim /usr/bin/vim && \
ln -fsr /usr/local/bin/vim /usr/bin/vi

#自身のvim環境をクローン
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim

#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv rc/.[^.]* ~ && \
#用が済んだらリム
rm -rf ~/tmp

#vim plugin manager
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#pythonコマンドいんすこ
RUN cd /usr/local/src && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
chown -R root:root Python-3.7.4 && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

#環境変数の設定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >>~/.bashrc && \
source ~/.bashrc

#ダイナミックリンクライブラリキャッシュの更新
#centosのデフォルトでは更新されないので、ビルド前に更新
#Python3系のリンク更新する(ソースビルドしたものが対象)
RUN echo '/usr/local/lib'>>/etc/ld.so.conf.d/local-ld.so.conf
RUN ldconfig
#python2系のヘッダファイルが追加される(postgresビルドに必要)
#RUN yum install -y python-devel
#postgresコマンドインストール
#RUN cd /usr/local/src && curl -LO https://ftp.postgresql.org/pub/source/v12.0/postgresql-12.0.tar.gz && \
#tar xvf postgresql-12.0.tar.gz && \
#chown -R root:root postgresql-12.0 && \
#cd postgresql-12.0 && \
#./configure --prefix=/usr/local --with-includes=/usr/local/include/python3.7m --libdir=/usr/local/lib/postgresql --with-python && \
#make -j12 && \
#make -j12 install

#レポジトリから配布されているソフトはできるのでそれにする
#ソースビルドとの差分見極める
RUN yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
RUN yum -y install postgresql12-server postgresql12-devel postgresql12-libs postgresql12-plpython3

USER postgres

#自身のvim環境をクローン
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim

#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv rc/.[^.]* ~ && \
#用が済んだらリム
rm -rf ~/tmp

#vim plugin manager
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#環境変数の設定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >>~/.bashrc && \
source ~/.bashrc
RUN echo 'export PATH=/usr/pgsql-12/bin:$PATH' >>~/.pgsql_profile && \
echo 'export PGDATA=/var/lib/pgsql/12/data'>>~/.pgsql_profile && \
source ~/.bashrc

WORKDIR /home/postgres

CMD ["/usr/sbin/init"]
