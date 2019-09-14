FROM centos:latest

#各種X関連コマンドインストール
RUN yum install -y xeyes xorg-x11-server-utils xterm xorg-x11-apps

RUN yum install -y java firefox

#Xwindowシステムパッケージいんすこ
RUN yum groups mark convert
RUN yum groupinstall -y base "X Window System" --setopt=group_package_types=mandatory,default,optional

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
RUN yum install -y fcitx ibus

#guiアプリインストール
#事前にダウンロードしておき、dockerコンテナにコピー。
COPY sqldeveloper-19.2.0.206.2117.noarch.rpm /root/sqldeveloper-19.2.0.206.2117.noarch.rpm
COPY jdk-8u221-linux-x64.rpm /root/jdk-8u221-linux-x64.rpm
RUN cd ~ && rpm -ivh jdk-8u221-linux-x64.rpm
RUN cd ~ && rpm -ivh sqldeveloper-19.2.0.206.2117.noarch.rpm

#pre installはユーザー作成とかフォルダとかパッケージとかをまとめていんすこしている
#main installでpreinstall実施チェックしているから、とりま実行しておくのがよい
RUN curl -o oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
RUN yum -y localinstall oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm && rm oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm

ENV ORACLE_DOCKER_INSTALL=true \
    ORACLE_HOME=/opt/oracle/product/19c/dbhome_1 \
    ORACLE_SID=ORCLCDB \
    PATH=$PATH:$ORACLE_HOME/bin

#事前にダウンロードしておき、dockerコンテナにコピー。
COPY oracle-database-ee-19c-1.0-1.x86_64.rpm /root/oracle-database-ee-19c-1.0-1.x86_64.rpm

RUN yum -y localinstall /root/oracle-database-ee-19c-1.0-1.x86_64.rpm

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN chsh -s /bin/bash rstudio
RUN chsh -s /bin/bash oracle
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'oracle_pwd' | passwd --stdin oracle
RUN echo 'oracle ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドインストール
RUN yum install -y epel-release 
RUN yum install -y R
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man rlwrap

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
RUN yum install -y gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
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

#python install
RUN cd ~ && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
cd Python-3.7.4 && \
./configure && \
make -j12 && \
make -j12 install

#perl install
RUN cd ~ && curl -LO https://www.cpan.org/src/5.0/perl-5.30.0.tar.gz && \
tar -xzf perl-5.30.0.tar.gz && \
cd perl-5.30.0 && \
./Configure -des -Dprefix=/usr/local/ && \
make -j12 && \
make -j12 install

#parallelコマンド install
RUN cd ~ && yum install -y bzip2 && curl -LO http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 && \
tar jxf parallel-latest.tar.bz2 && \
cd parallel-20190822 && \
./configure && \
make -j12 && \
make -j12 install

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1" >> ~/.bashrc && \
echo "export ORACLE_SID=ORCLCDB"  >> ~/.bashrc && \
echo "export PATH=$PATH:$ORACLE_HOME/bin" >> ~/.bashrc

#実行ユーザをrstudioに変更
USER rstudio

#自身のvim環境をクローン
RUN cd ~ && git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim

#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN cd ~ && git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
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
echo "export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1" >> ~/.bashrc && \
echo "export ORACLE_SID=ORCLCDB"  >> ~/.bashrc && \
echo "export PATH=$PATH:$ORACLE_HOME/bin" >> ~/.bashrc

#実行ユーザをoracleに変更
USER oracle

#自身のvim環境をクローン
RUN cd ~ && git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim

#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN cd ~ && git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
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
echo "export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1" >> ~/.bashrc && \
echo "export ORACLE_SID=ORCLCDB"  >> ~/.bashrc && \
echo "export PATH=$PATH:$ORACLE_HOME/bin:$HOME/sqlcl/bin" >> ~/.bashrc && \
echo "export NLS_LANG=Japanese_Japan.AL32UTF8" >> ~/.bashrc && \
echo "alias sqlplus=\"rlwrap -pRed sqlplus\"" >> ~/.bashrc && \
echo "alias sqldev=\"echo /usr/java/jdk1.8.0_221-amd64 | sudo /opt/sqldeveloper/sqldeveloper.sh -conf /opt/sqldeveloper/sqldeveloper/bin/sqldeveloper.conf >~/launch_sqldeveloper.log 2>&1 &\"" >> ~/.bashrc

#sqlplusの進化版SQLclインストール
#jdk必要。java製なので。
RUN java -version
#事前にダウンロードしておき、dockerコンテナにコピー。
COPY sqlcl-19.2.1.206.1649.zip /home/oracle/sqlcl-19.2.1.206.1649.zip
RUN cd ~ && unzip sqlcl-19.2.1.206.1649.zip

#最後はrootに戻す
USER root 

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#oracleインスタンス起動スクリプト修正
RUN sed -i '34i export PASSWORD=ORACLE_PWD' /etc/init.d/oracledb_ORCLCDB-19c && \
 sed -i '165s;^;#;' /etc/init.d/oracledb_ORCLCDB-19c && \
 sed -i '166i $SU -s /bin/bash  $ORACLE_OWNER -c "$DBCA -silent -createDatabase -gdbName $ORACLE_SID -templateName $TEMPLATE_NAME -characterSet $CHARSET -createAsContainerDatabase $CREATE_AS_CDB -createListener $LISTENER_NAME:$LISTENER_PORT -datafileDestination $ORACLE_DATA_LOCATION -sid $ORACLE_SID -sysPassword $PASSWORD -systemPassword $PASSWORD -emConfiguration DBEXPRESS -emExpressPort $EM_EXPRESS_PORT"' /etc/init.d/oracledb_ORCLCDB-19c

#sqlクライアントサービス外部公開ポート
EXPOSE 1521

#sqlemサービス外部公開ポート
EXPOSE 5500

#sshdサービス外部公開ポート
EXPOSE 22

#rstudioサービス外部公開ポート
EXPOSE 8787

#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

COPY glogin.sql /opt/oracle/product/19c/dbhome_1/sqlplus/admin/glogin.sql
COPY init_db.sh /home/oracle/init_db.sh
COPY launch_and_open_db.sql /home/oracle/launch_and_open_db.sql

RUN chown oracle:oinstall /home/oracle/* && chmod +x /home/oracle/*
