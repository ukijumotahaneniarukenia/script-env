FROM ubuntu:19.10

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y git gcc make lsb-release wget gnupg sudo libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev clang clang-format clang-tools unzip

#ユーザー作成
RUN groupadd -g 1001 mysql && \
useradd -m -g mysql -u 1001 mysql && \
echo 'mysql:mysql_pwd' | chpasswd && \
echo 'mysql ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash mysql

RUN echo 'root:root_pwd' | chpasswd

#X環境インストール
RUN apt-get install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#vimも最新
#RUN grep '^deb ' /etc/apt/sources.list | sed 's/^deb/deb-src/g' > /etc/apt/sources.list.d/deb-src.list && \
#apt-get update && \
#apt-get build-dep -y vim && \
#cd /usr/local/src && git clone https://github.com/vim/vim.git && \
#./configure --with-features=huge --with-x --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=dynamic --enable-gui=auto --enable-gtk2-check && \
#make -j12 && \
#make -j12 install && \
#ln -fsr /usr/local/bin/vim /usr/bin/vi

#cpp環境構築
#RUN git clone https://github.com/cquery-project/cquery --single-branch --depth=1 && \
#cd cquery && \
#git submodule update --init && ./waf configure --variant=system --llvm-config=/usr/bin/llvm-config build
#
##自身のvim環境をクローン
#RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#
##自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
#RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
#cd ~/tmp && \
##移動したいdotfileをchoiceしてHOMEディレクトリへ
#mv rc/.[^.]* ~ && \
##用が済んだらリム
#rm -rf ~/tmp
#
##vim plugin manager
#RUN mkdir -p ~/.vim/bundle && \
#cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
#sh installer.sh ~/.vim/bundle && rm -rf installer.sh
