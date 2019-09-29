FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN chsh -s /bin/bash rstudio
RUN groupadd -g 1002 php
RUN useradd -m -g php -u 1002 php
RUN chsh -s /bin/bash php
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'php_pwd' | passwd --stdin php
RUN echo 'php ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドインストール
RUN yum install -y epel-release
RUN yum install -y R
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man file

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
cd parallel-20190922 && \
./configure && \
make -j12 && \
make -j12 install

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "export GTK_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export XMODIFIERS=@im=ibus" >> ~/.bashrc && \
echo "export QT_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export DefalutIMModule=ibus" >> ~/.bashrc && \
echo "export NO_AT_BRIDGE=1" >> ~/.bashrc && \
echo "xset -r 49" >> ~/.bashrc && \
echo "ibus-daemon -dxr" >> ~/.bashrc && \
echo "xrdb ~/.Xresources" >> ~/.bashrc

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
echo "export GTK_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export XMODIFIERS=@im=ibus" >> ~/.bashrc && \
echo "export QT_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export DefalutIMModule=ibus" >> ~/.bashrc && \
echo "export NO_AT_BRIDGE=1" >> ~/.bashrc && \
echo "xset -r 49" >> ~/.bashrc && \
echo "ibus-daemon -dxr" >> ~/.bashrc && \
echo "xrdb ~/.Xresources" >> ~/.bashrc

USER php

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
echo "export PATH=/home/php/Komodo-Edit-11/bin:$PATH" >> ~/.bashrc && \
echo "alias komodo=\"komodo > ~/launch_komodo.log 2>&1 &\"" >> ~/.bashrc && \
echo "export GTK_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export XMODIFIERS=@im=ibus" >> ~/.bashrc && \
echo "export QT_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export DefalutIMModule=ibus" >> ~/.bashrc && \
echo "export NO_AT_BRIDGE=1" >> ~/.bashrc && \
echo "xset -r 49" >> ~/.bashrc && \
echo "ibus-daemon -dxr" >> ~/.bashrc && \
echo "xrdb ~/.Xresources" >> ~/.bashrc

#komodoエディタいんすこ
COPY Komodo-Edit-11.1.1-18206-linux-x86_64.tar.gz /home/php/Komodo-Edit-11.1.1-18206-linux-x86_64.tar.gz
RUN cd ~ && tar -xzf Komodo-Edit-11.1.1-18206-linux-x86_64.tar.gz

#phpいんすこ
RUN sudo yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
 sudo yum -y install --enablerepo=remi,remi-php73 php php-devel php-mbstring php-pdo php-gd php-xml php-mcrypt

USER root

#各種X関連コマンドインストール
RUN yum install -y xeyes xorg-x11-server-utils xterm xorg-x11-apps

RUN yum install -y java firefox

#Xwindowシステムパッケージいんすこ
RUN yum -y groupinstall "X Window System"
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#IMEいんすこ
#かな漢字install
RUN yum install -y fcitx ibus
RUN yum groupinstall -y "Input Methods"

#日本語環境と時刻合わせ
RUN yum install -y glibc-common
RUN yum reinstall -y glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# manと、man-pagesをインストール
RUN yum -y install man
RUN yum -y install man-pages.noarch
RUN yum -y install man-pages-ja.noarch
# cat /etc/yum.conf配下の
# tsflags=nodocsのため
RUN yum --setopt=tsflags='' reinstall -y man-pages

#絵文字いんすこ
RUN mkdir -p /usr/share/fonts/emoji && cd /usr/share/fonts/emoji && curl -LO https://noto-website-2.storage.googleapis.com/pkgs/Noto-unhinted.zip && unzip Noto-unhinted.zip && rm Noto-unhinted.zip && fc-cache -f -v

#ibus-mozcインストール
RUN yum install -y ibus-mozc

#sshdサービス外部公開ポート
EXPOSE 22

#rstudioサービス外部公開ポート
EXPOSE 8787

#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

USER php

#配下にあるinstall.shを実行する
#/home/php/Komodo-IDE-11.1.1-91089-linux-x86_64
WORKDIR /home/php
