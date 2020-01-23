FROM ubuntu:19.10

#レポジトリを日本サーバーに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update

RUN apt-get install -y git gcc autoconf automake make lua5.3 luajit liblua5.3-0 liblua5.3-dev libperl-dev libpython-dev python-dev python3-dev tcl tcl-dev ruby-dev
