FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1001 racket
RUN useradd -m -g racket -u 1001 racket
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'racket_pwd' | passwd --stdin racket
RUN echo 'racket ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#epelレポ登録
RUN yum -y install epel-release

#各種コマンドインストール
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils

#各種X関連コマンドインストール
RUN yum install -y xeyes xorg-x11-server-utils xterm xorg-x11-apps firefox

#Xwindowシステムパッケージいんすこ
RUN yum groupinstall -y base "X Window System" --setopt=group_package_types=mandatory,default,optional

#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

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

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#alias設定
RUN echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo "export GTK_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export XMODIFIERS=@im=ibus" >> ~/.bashrc && \
echo "export QT_IM_MODULE=ibus" >> ~/.bashrc && \
echo "export DefalutIMModule=ibus" >> ~/.bashrc && \
echo "export NO_AT_BRIDGE=1" >> ~/.bashrc && \
echo "xset -r 49" >> ~/.bashrc && \
echo "ibus-daemon -rxd" >> ~/.bashrc && \
echo "xrdb ~/.Xresources" >> ~/.bashrc

#実行ユーザ変更
USER racket

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
RUN echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc

#実行ユーザ変更
USER root

#racketいんすこ
RUN cd ~ && curl -LO https://mirror.racket-lang.org/installers/7.5/racket-7.5-x86_64-linux.sh && \
chmod +x racket-7.5-x86_64-linux.sh && \
echo 2 | ./racket-7.5-x86_64-linux.sh --unix-style

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#入力メソッドいんすこ
RUN yum install -y ibus-mozc

#実行ユーザ変更
USER racket

WORKDIR /home/racket
