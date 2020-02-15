#!/bin/bash

#dockerインストール
yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate 
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker

#ユーザーをグループに追加
usermod -aG docker aine

#chromeインストール
cat <<EOF >/etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
yum install -y google-chrome-stable

#ibus-mozcインストール
yum install -y epel-release
yum install -y ibus-mozc

#VIM最新インストール
mkdir -p $HOME/pkg/vim && yum install -y git && yum install -y gcc gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
cd $HOME && git clone https://github.com/vim/vim.git $HOME/pkg/vim && \
cd $HOME/pkg/vim && \
./configure --enable-multibyte --with-features=huge --enable-cscope --enable-gui=gtk2 --disable-selinux --prefix=/usr/local --enable-xim --enable-fontset --enable-gpm --enable-rubyinterp --with-python-config-dir=/usr/lib/python2.7/config && \
make -j12 distclean && \
make -j12 && \
make -j12 install && \
ln -fsr /usr/local/bin/vim /usr/bin/vim && \
ln -fsr /usr/local/bin/vim /usr/bin/vi

# 自身のvim環境クローン
rm -rf $HOME/.vim && \
git clone https://github.com/ukijumotahaneniarukenia/.vim.git $HOME/.vim && \
git clone https://github.com/ukijumotahaneniarukenia/dotfile.git $HOME/tmp && \
cd $HOME/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv rc/.[^.]* $HOME && \
#用が済んだらリム
rm -rf $HOME/tmp

#vim plugin manager
mkdir -p $HOME/.vim/bundle && \
cd $HOME && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh $HOME/.vim/bundle && rm -rf installer.sh
