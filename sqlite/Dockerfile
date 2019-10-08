FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN groupadd -g 1002 sqlite
RUN useradd -m -g sqlite -u 1002 sqlite
RUN adduser postgres
RUN chsh -s /bin/bash rstudio
RUN chsh -s /bin/bash postgres
RUN chsh -s /bin/bash sqlite
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'postgres_pwd' | passwd --stdin postgres
RUN echo 'sqlite_pwd' | passwd --stdin sqlite
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'postgres ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'sqlite ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#epelレポ登録
RUN yum -y install epel-release

#各種コマンドインストール
RUN yum install -y R
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man

#レポジトリ登録
RUN yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
#登録したレポジトリからインストール
RUN yum -y install pgadmin4

#サーバモード指定
RUN echo "SERVER_MODE = True" >> /usr/lib/python2.7/site-packages/pgadmin4-web/config_local.py
#外部からのアクセスを可能にする
RUN echo "DEFAULT_SERVER = '0.0.0.0'" >> /usr/lib/python2.7/site-packages/pgadmin4-web/config_local.py
RUN echo "LOG_FILE = '/var/log/pgadmin4/pgadmin4.log'" >> /usr/lib/python2.7/site-packages/pgadmin4-web/config_local.py

#perl パッケージ管理cpanmないしcpanインストール
RUN yum install -y which perl-App-cpanminus wxGTK-devel perl-ExtUtils-Embed perl-File-HomeDir perl-Term-ReadLine-Gnu wxGTK3 cpan

#Tukubaiコマンドは便利
RUN cd ~ && git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make -j12 install

#awkコマンドは最新の奴 include使える
RUN cd ~ && curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make -j12 && \
make -j12 install

#bashも最新
RUN cd ~ && curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
tar -zxvf bash-5.0.tar.gz && \
cd bash-5.0 && \
./configure && \
make -j12 && \
make -j12 install

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

#parallelコマンド install
RUN cd ~ && yum install -y bzip2 && curl -LO http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 && \
tar jxf parallel-latest.tar.bz2 && \
cd parallel-20190922 && \
./configure && \
make -j12 && \
make -j12 install

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo "alias sqlite=/usr/local/bin/sqlite3" >> ~/.bashrc

#実行ユーザをpostgresに変更
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

# sampleスキーマのフェッチ
RUN cd ~ && curl -LO http://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
RUN cd ~ && sudo yum install -y unzip && unzip dvdrental.zip

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo "alias sqlite=/usr/local/bin/sqlite3" >> ~/.bashrc

#実行ユーザをrstudioに変更
USER rstudio

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

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo "alias sqlite=/usr/local/bin/sqlite3" >> ~/.bashrc

#実行ユーザをsqliteに変更
USER sqlite

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

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo "alias sqlite=/usr/local/bin/sqlite3" >> ~/.bashrc

USER root 

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#No such file or directory /etc/init.d/functionsの対策のためいんすこ
RUN yum install -y initscripts
RUN yum install -y --nogpgcheck https://s3.amazonaws.com/rstudio-ide-build/server/centos6/x86_64/rstudio-server-rhel-1.2.1568-x86_64.rpm 

#sqlite install
RUN cd ~ && curl -LO https://www.sqlite.org/2019/sqlite-autoconf-3300000.tar.gz && \
tar xvf sqlite-autoconf-3300000.tar.gz && \
cd sqlite-autoconf-3300000 && \
./configure --prefix=/usr/local --enable-readline | tee log && \
make -j12 | tee sqlite_logg && \
make -j12 install | tee sqlite_loggg

#python install
RUN cd /usr/local/src && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
chown -R root:root Python-3.7.4 && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

#perl install
RUN cd ~ && curl -LO https://www.cpan.org/src/5.0/perl-5.30.0.tar.gz && \
tar -xzf perl-5.30.0.tar.gz && \
echo
#cd perl-5.30.0 && \
#./Configure -des -Dprefix=/usr/local/ && \
#make -j12 && \
#make -j12 install

#postgresビルド時にこけるのを防ぐ
#python2.7のC言語のヘッダファイルを準備するため、いんすこしている
#dockerコンテナ作成後の手順に移植
#RUN yum install -y python-devel

#postgres12 install
#dockerコンテナ作成後の手順に移植
RUN cd /usr/local/src && curl -LO https://ftp.postgresql.org/pub/source/v12.0/postgresql-12.0.tar.gz && \
tar xvf postgresql-12.0.tar.gz && \
chown -R root:root postgresql-12.0 && \
echo
#cd postgresql-12.0 && \
#./configure --prefix=/usr/local --with-python --with-includes=/usr/local/include/python3.7m --with-libraries=/lib64 | tee log && \
#make -j12 | tee logg && \
#make -j12 install | tee loggg

#plpython3を使えるようにする
#dockerコンテナ作成後の手順に移植
#RUN ln -s /usr/local/lib/libpython3.7m.so.1.0 /usr/lib64/libpython3.7.so && \
#ln -s /usr/local/lib/libpython3.7m.so.1.0 /usr/lib64/libpython3.7m.so.1.0 && \
#ldconfig && \
#cd /usr/local/src/postgresql-12.0/src/pl/plpython && \
#gcc -std=gnu99 -Wall -Wmissing-prototypes -Wpointer-arith -Wdeclaration-after-statement -Werror=vla -Wendif-labels -Wmissing-format-attribute -Wformat-security -fno-strict-aliasing -fwrapv -fexcess-precision=standard -O2 -fPIC -shared -o plpython3.so plpy_cursorobject.o plpy_elog.o plpy_exec.o plpy_main.o plpy_planobject.o plpy_plpymodule.o plpy_procedure.o plpy_resultobject.o plpy_spi.o plpy_subxactobject.o plpy_typeio.o plpy_util.o  -L../../../src/port -L../../../src/common    -Wl,--as-needed -Wl,-rpath,'/usr/lib64',--enable-new-dtags  -L/usr/lib64 -lpython3.7m -lpthread -ldl  -lutil -lm && \
#/usr/bin/install -c -m 755  plpython3.so '/usr/local/lib/postgresql/plpython3.so' && \
#/usr/bin/install -c -m 644 ./plpython3u.control ./plpython3u--1.0.sql ./plpython3u--unpackaged--1.0.sql '/usr/local/share/postgresql/extension/'

#sshdサービス外部公開ポート
EXPOSE 22

#postgresサービス外部公開ポート
EXPOSE 5432

#pgAdminサービス外部公開ポート
EXPOSE 5050

#最後はsqliteに戻す
USER sqlite

#postgres起動
#dockerコンテナ作成後の手順に移植
#RUN initdb -D ~/pgdata && \
#pg_ctl -D ~/pgdata -l logfile start && \
#psql -U postgres -c "create database test_01" && \
#psql -U postgres -d test_01 -c "SELECT * FROM pg_available_extensions;" && \
#psql -U postgres -d test_01 -c "CREATE EXTENSION plpython3u;" && \
#psql -U postgres -d test_01 -c "SELECT * FROM pg_available_extensions;"

WORKDIR /home/sqlite
