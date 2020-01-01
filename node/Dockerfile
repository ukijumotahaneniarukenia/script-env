FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1001 kuraine
RUN useradd -m -g kuraine -u 1001 kuraine
RUN chsh -s /bin/bash kuraine
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'kuraine_pwd' | passwd --stdin kuraine
RUN echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドいんすこ
RUN yum -y install epel-release
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which

# ビルド用にgo言語いんすこ
RUN cd ~ && mkdir ~/go1.4 && mkdir ~/tmp && \
curl -LO https://dl.google.com/go/go1.4.3.linux-amd64.tar.gz && \
tar xvf go1.4.3.linux-amd64.tar.gz -C ~/tmp/ && \
mv ~/tmp/go/* ~/go1.4 && \
rm -rf ~/tmp
# 新バージョンのgo言語いんすこ
##https://github.com/astaxie/build-web-application-with-golang/blob/master/ja/01.1.md
RUN cd ~ && rm -rf ~/tmp && mkdir ~/tmp && curl -LO https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
cd ~ && tar xvf go1.13.5.linux-amd64.tar.gz -C ~/tmp/ && \
cd ~/tmp/go/src/ && \
./all.bash && \
mv /root/tmp/go /usr/local/go1.13

#javaコマンドいんすこ
RUN cd /usr/local/src && curl -LO https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz && \
tar xvf openjdk-13*_bin.tar.gz && \
ln -fsr /usr/local/src/jdk-13.0.1/bin/javac /usr/local/bin/javac && \
ln -fsr /usr/local/src/jdk-13.0.1/bin/java /usr/local/bin/java && \
ln -fsr /usr/local/src/jdk-13.0.1/bin/jshell /usr/local/bin/jshell && \
ln -fsr /usr/local/src/jdk-13.0.1/bin/jar /usr/local/bin/jar

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
RUN yum install -y libtool && git clone https://github.com/kkos/oniguruma.git && \
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
./configure --prefix=/usr/local --enable-readline | tee log && \
make -j12 | tee logg && \
make -j12 install | tee loggg

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
RUN cd ~ && git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make -j12 install

#awkこまんどいんすこ
RUN cd ~ && curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make -j12 && \
make -j12 install

#bashこまんどいんすこ
RUN cd ~ && curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
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
RUN echo "export GOROOT=/usr/local/go1.13">>~/.bashrc && \
echo "export PATH=$PATH:$GOROOT/bin">>~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
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

#gitコマンドいんすこ
RUN yum install -y gcc autoconf && \
yum install -y curl-devel expat-devel gettext-devel openssl-devel perl-devel zlib-devel perl-ExtUtils-MakeMaker && \
yum install -y asciidoc xmlto docbook2X && \
ln -fns /usr/bin/db2x_docbook2texi /usr/bin/docbook2x-texi && \
sudo curl -LkvOf https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.24.1.tar.gz && \
sudo tar xvf git-2.24.1.tar.gz && \
cd git-2.24.1/ && \
make -j12 prefix=/usr/local all && \
sudo make -j12 prefix=/usr/local install

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

#環境変数設定
RUN echo 'export GOROOT=/usr/local/go1.13'>>~/.bashrc && \
echo 'export PATH=$PATH:$GOROOT/bin'>>~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo 'alias vim="sudo vim"'>>~/.bashrc && \
echo 'alias vi="sudo vim"'>>~/.bashrc && \
source ~/.bashrc

#VScodeいんすこ
COPY code-1.41.1-1576681965.el7.x86_64.rpm /home/kuraine/code-1.41.1-1576681965.el7.x86_64.rpm

WORKDIR /home/kuraine
