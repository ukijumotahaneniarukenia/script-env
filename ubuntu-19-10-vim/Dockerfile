FROM ubuntu:19.10

#レポジトリを日本サーバーに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt-get install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh

#vimコマンドインストール
RUN apt-get install -y git gcc autoconf automake make lua5.3 luajit liblua5.3-0 liblua5.3-dev libperl-dev libpython-dev python-dev python3-dev tcl tcl-dev ruby-dev perl5*-dev
RUN grep '^deb ' /etc/apt/sources.list | sed 's/^deb/deb-src/g' > /etc/apt/sources.list.d/deb-src.list && apt-get update
RUN apt-get build-dep -y vim
RUN cd /usr/local/src && \
git clone https://github.com/vim/vim.git && \
cd vim && \
./configure --with-features=huge --with-x --with-python-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=dynamic --enable-tclinterp=dynamic --enable-perlinterp=dynamic --enable-gui=auto --enable-gtk2-check && \
make -j12 && \
make -j12 install && \
ln -fsr /usr/local/bin/vim /usr/bin/vi

#pythonコマンドインストール
RUN apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev
RUN cd /usr/local/src && \
curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar xvf Python-3.7.4.tgz && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

#.vimインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#dotfileインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
mv rc/.[^.]* ~ && \
rm -rf ~/tmp
#ライブラリ管理dein.vimインストール
RUN apt install -y curl && \
mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
cd ~ && sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
echo 'kuraine:kuraine_pwd' | chpasswd && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash kuraine

RUN echo 'root:root_pwd' | chpasswd

#環境変数
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && . ~/.bashrc

USER kuraine

#vimインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#dotfileインストール
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
mv rc/.[^.]* ~ && \
rm -rf ~/tmp
#ライブラリ管理dein.vimインストール
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
cd ~ && sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#環境変数
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && . ~/.bashrc

WORKDIR /home/kuraine
