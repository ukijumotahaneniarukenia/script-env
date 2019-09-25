FROM centos:latest

#各種X関連コマンドインストール
RUN yum install -y xeyes xorg-x11-server-utils xterm xorg-x11-apps

RUN yum install -y java firefox

#Xwindowシステムパッケージいんすこ
RUN yum groupinstall -y base "X Window System" --setopt=group_package_types=mandatory,default,optional

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN chsh -s /bin/bash rstudio
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドインストール
RUN yum install -y epel-release git

RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man


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

#alias設定
RUN echo "alias python=/usr/local/bin/python3.7" >> ~/.bashrc && \
echo "alias pip=/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo "alias perl=/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=/usr/local/bin/parallel" >> ~/.bashrc && \
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
RUN echo "alias python=/usr/local/bin/python3.7" >> ~/.bashrc && \
echo "alias pip=/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo "alias perl=/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=/usr/local/bin/parallel" >> ~/.bashrc && \
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

#最後はrootに戻す
USER root 

RUN yum install -y ibus-mozc

#日本語環境と時刻合わせ
RUN yum install -y glibc-common
RUN yum reinstall -y glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#かな漢字install
RUN yum groupinstall -y "Input Methods"

# manと、man-pagesをインストール
RUN yum -y install man
RUN yum -y install man-pages.noarch
RUN yum -y install man-pages-ja.noarch
# cat /etc/yum.conf配下の
# tsflags=nodocsのため
RUN yum --setopt=tsflags='' reinstall -y man-pages


#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

CMD ["/sbin/init"]
