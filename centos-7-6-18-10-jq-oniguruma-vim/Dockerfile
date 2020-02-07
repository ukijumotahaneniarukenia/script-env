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
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which perl-Digest-SHA


#xargsコマンド最新化
RUN cd /usr/local/src && curl -LO https://ftp.gnu.org/pub/gnu/findutils/findutils-4.7.0.tar.xz && \
tar xvf findutils-4.7.0.tar.xz && \
cd findutils-4.7.0 && \
./configure && \
make -j12 && \
make -j12 install

#gccいんすこ
RUN yum install -y lbzip gcc-c++ libtool makeinfo file && cd /usr/local/src && curl -LO http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/gcc-7.5.0/gcc-7.5.0.tar.gz && \
tar xvf gcc-7.5.0.tar.gz && cd gcc-7.5.0 && \
./contrib/download_prerequisites && \
./configure --enable-languages=c,c++ --prefix=/usr/local --disable-bootstrap --disable-multilib && \
make -j12 && \
make -j12 install

#nodeとyarnパッケージ管理コマンドいんすこ
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash - && \
 yum install -y nodejs && \
 yum install -y gcc-c++ make && \
 curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
 yum install -y yarn

#onigurumaいんすこ
RUN yum install -y libtool && cd /usr/local/src && git clone https://github.com/kkos/oniguruma.git && \
cd oniguruma && autoreconf -vfi && \
./configure --prefix=/usr/local --enable-shared && \
make -j12 && \
make -j12 install

#jqコマンドいんすこ
RUN cd /usr/local/src && curl -LO https://github.com/stedolan/jq/releases/download/jq-1.6/jq-1.6.tar.gz && \
tar xvf jq-1.6.tar.gz && cd jq-1.6 && \
./configure && \
make -j12 && \
make -j12 install

#sqlite install
RUN cd /usr/local/src && curl -LO https://www.sqlite.org/2019/sqlite-autoconf-3300000.tar.gz && \
tar xvf sqlite-autoconf-3300000.tar.gz && \
cd sqlite-autoconf-3300000 && \
./configure --prefix=/usr/local --enable-readline && \
make -j12 && \
make -j12 install

#python install
RUN cd /usr/local/src && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
chown -R root:root Python-3.7.4 && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

#gron install
RUN cd /usr/local/src && curl -LO https://github.com/tomnomnom/gron/releases/download/v0.6.0/gron-linux-amd64-0.6.0.tgz && \
tar xvf gron-linux-amd64-0.6.0.tgz -C /usr/local/bin

#Tukubaiコマンドいんすこ
RUN cd /usr/local/src && git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make -j12 install

#awkこまんどいんすこ
RUN cd /usr/local/src && curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make -j12 && \
make -j12 install

#bashこまんどいんすこ
RUN cd /usr/local/src && curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
tar -zxvf bash-5.0.tar.gz && \
cd bash-5.0 && \
./configure && \
make -j12 && \
make -j12 install

#trdsqlコマンドいんすこ
RUN cd /usr/local/src && \
curl -LO https://github.com/noborus/trdsql/releases/download/v0.7.3/trdsql_v0.7.3_linux_amd64.zip && \
yum install -y unzip && \
unzip trdsql_v0.7.3_linux_amd64.zip && \
cd trdsql_v0.7.3_linux_amd64 && \
cp /usr/local/src/trdsql_v0.7.3_linux_amd64/trdsql /usr/local/bin/trdsql

#gitコマンドいんすこ
RUN yum install -y gcc autoconf && \
yum install -y curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel perl-ExtUtils-MakeMaker && \
yum install -y asciidoc xmlto docbook2X && \
ln -fns /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi && \
cd /usr/local/src && \
curl -LkvOf https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.24.1.tar.gz && \
tar xvf git-2.24.1.tar.gz && \
cd git-2.24.1/ && \
make -j12 prefix=/usr/local all && \
make -j12 prefix=/usr/local install

#rubyコマンドいんすこ
RUN yum install -y bison && \
git clone https://github.com/ruby/ruby.git && \
cd ruby && \
autoconf && \
yum install -y ruby && \
./configure --prefix=/usr/local --enable-shared && \
make -j12 && \
make -j12 install

#sedコマンドいんすこ
RUN cd /usr/local/src && \
curl -LO http://ftp.gnu.org/gnu/sed/sed-4.7.tar.xz && \
tar xvf sed-4.7.tar.xz && \
cd sed-4.7 && \ 
./configure --prefix=/usr/local && \
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

#環境変数設定
RUN echo 'export GOROOT=/usr/local/bin/go1.13'>>~/.bashrc && \
echo 'export PATH=$PATH:$GOROOT/bin'>>~/.bashrc && \
echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
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

#elasticインストール
RUN cd /usr/local/src && curl -LO https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.5.1-x86_64.rpm && \
yum install -y elasticsearch-7.5.1-x86_64.rpm

#kibanaいんすこ
RUN cd /usr/local/src && curl -LO https://artifacts.elastic.co/downloads/kibana/kibana-7.5.1-x86_64.rpm && \
yum install -y kibana-7.5.1-x86_64.rpm
RUN sed -i 's;#server.port: 5601;server.port: 5601;' /etc/kibana/kibana.yml
RUN ( IP=$(ifconfig eth0 | grep inet | sed -E 's;\s{1,}; ;' | cut -d" " -f 3) && sed -i "s;#server.host: \"localhost\";server.host: \"$IP\";" /etc/kibana/kibana.yml )

USER elasticsearch

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

USER kibana

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

USER kuraine

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

#環境変数設定
RUN echo 'export GOROOT=/usr/local/bin/go1.13'>>~/.bashrc && \
echo 'export PATH=$PATH:$GOROOT/bin'>>~/.bashrc && \
echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'alias idea="/home/kuraine/idea-IC-192.7142.36/bin/idea.sh >~/launch_idea.log 2>&1 &"' >> ~/.bashrc && \
source ~/.bashrc

#VScodeいんすこ
COPY code-1.41.1-1576681965.el7.x86_64.rpm /home/kuraine/code-1.41.1-1576681965.el7.x86_64.rpm
RUN cd ~ && sudo yum install -y code-1.41.1-1576681965.el7.x86_64.rpm

#ideaいんすこ
COPY ideaIC-2019.2.4.tar.gz /home/kuraine/ideaIC-2019.2.4.tar.gz
RUN cd ~ && tar -xzf ideaIC-2019.2.4.tar.gz && chown -R kuraine:kuraine idea-IC-192.7142.36

#elasticサービス外部公開ポート
EXPOSE 9200

#kibanaサービス外部公開ポート
EXPOSE 5601

#httpdサービス外部公開ポート
EXPOSE 8080

WORKDIR /home/kuraine

#systemctlコマンド周りのエラー解消用。一度dockerホストマシンの再起動が起きる
#httpdサービス関連のみ。それ以外は解消しないので、泥臭く起動
CMD ["/sbin/init"]
