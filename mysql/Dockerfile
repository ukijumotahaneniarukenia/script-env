FROM centos:latest

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN groupadd -g 1002 mysql
RUN useradd -m -g mysql -u 1002 mysql
RUN groupadd -g 1003 apache
RUN useradd -m -g rstudio -u 1003 apache
RUN chsh -s /bin/bash rstudio
RUN chsh -s /bin/bash mysql
RUN chsh -s /bin/bash apache
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'mysql_pwd' | passwd --stdin mysql
RUN echo 'mysql ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'apache_pwd' | passwd --stdin apache
RUN echo 'apache ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドインストール
RUN yum install -y epel-release
RUN yum install -y R
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man httpd

#phpインストール
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
RUN yum install -y --disablerepo=* --enablerepo=epel,remi,remi-safe,remi-php73 php php-mysqlnd

#phpadminインストール
RUN cd /usr/share && curl -LO https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz && \
tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz && \
mv phpMyAdmin-4.9.0.1-all-languages phpmyadmin && \
chown -R apache:apache /usr/share/phpmyadmin && \
chmod -R 755 /usr/share/phpmyadmin && \
mkdir -p /etc/httpd/conf.d

#phpadmin設定ファイル
RUN echo "<Directory \"/usr/share/phpmyadmin\">" >> /etc/httpd/conf.d/phpmyadmin.conf
RUN echo "  Require all granted" >> /etc/httpd/conf.d/phpmyadmin.conf
RUN echo "  AllowOverride all" >> /etc/httpd/conf.d/phpmyadmin.conf
RUN echo "</Directory>" >> /etc/httpd/conf.d/phpmyadmin.conf

#mysqlインストール
RUN yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
RUN yum install -y mysql-community-server
# ログのタイムゾーンの設定（初期値：UTC）
RUN echo log_timestamps=SYSTEM >> /etc/my.cnf
# クライアントの文字セットの設定を無視する
RUN echo skip-character-set-client-handshake >> /etc/my.cnf
# デフォルトの文字セット（初期値：utf8mb4 >= 8.0.1）
RUN echo character-set-server=utf8mb4 >> /etc/my.cnf
# タイムスタンプのデフォルト値に関する設定（初期値：ON >= 8.0.2）
RUN echo explicit_defaults_for_timestamp=ON >> /etc/my.cnf

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
sh installer.sh ~/.vim/bundle

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
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc

#実行ユーザをmysqlに変更
USER mysql

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
sh installer.sh ~/.vim/bundle

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc

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
sh installer.sh ~/.vim/bundle

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc

#実行ユーザをapacheに変更
USER apache

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
sh installer.sh ~/.vim/bundle

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc

#最後はrootに戻す
USER root 

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#mysqlセキュリティ設定自動化
RUN echo "OLD_PWD=\$(grep password /var/log/mysqld.log | cut -d\" \" -f 13)" >> ~/a.sh
RUN echo "NEW_PWD=Mysql-3306" >> ~/a.sh
RUN echo "expect -c \"spawn mysql_secure_installation --use-default" >> ~/a.sh
RUN echo "expect \\\"user root:\\\"" >> ~/a.sh
RUN echo "send \\\"\${OLD_PWD}\n\\\"" >> ~/a.sh
RUN echo "expect \\\"New password:\\\"" >> ~/a.sh
RUN echo "send \\\"\${NEW_PWD}\n\\\"" >> ~/a.sh
RUN echo "expect \\\"Re-enter new password:\\\"" >> ~/a.sh
RUN echo "send \\\"\${NEW_PWD}\n\\\"" >> ~/a.sh
RUN echo "expect \\\"$\\\"" >> ~/a.sh
RUN echo "exit 0 \"" >> ~/a.sh
RUN echo "mysql -u root -pMysql-3306 -e \"show databases;\"" >> ~/a.sh
RUN echo "mysql -u root -pMysql-3306 -e \"CREATE USER \"mysql_test\"@\"localhost\" IDENTIFIED WITH mysql_native_password BY \\\"Mysql-3306\\\";\"" >> ~/a.sh
RUN echo "mysql -u root -pMysql-3306 -e \"GRANT ALL PRIVILEGES ON mysql.* TO \"mysql_test\"@\"localhost\" WITH GRANT OPTION;\"" >> ~/a.sh
RUN chmod +x ~/a.sh

#サンプルデータベース展開
RUN cd ~ && curl -LO https://github.com/datacharmer/test_db/archive/master.zip
RUN cd ~ && curl -LO https://downloads.mysql.com/docs/world.sql.zip
RUN cd ~ && curl -LO https://downloads.mysql.com/docs/world_x-db.zip
RUN cd ~ && curl -LO https://downloads.mysql.com/docs/sakila-db.zip
RUN cd ~ && curl -LO https://downloads.mysql.com/docs/menagerie-db.zip

#rstudioサービス外部公開ポート
EXPOSE 8787

#mysqlサービス外部公開ポート
EXPOSE 3306

#sshdサービス外部公開ポート
EXPOSE 22

#httpdサービス外部公開ポート
EXPOSE 80

CMD ["/sbin/init"]
