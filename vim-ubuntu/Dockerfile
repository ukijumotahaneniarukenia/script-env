FROM ubuntu:19.10

#レポジトリを日本サーバーに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

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
