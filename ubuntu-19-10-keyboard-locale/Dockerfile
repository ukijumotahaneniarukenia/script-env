FROM ubuntu:19.10

#https://qiita.com/munky69rock/items/4c3a076fe496045de5f1
#Setting up keyboard-configuration (1.191ubuntu3) ...
#Your console font configuration will be updated the next time your system
#boots. If you want to update it now, run 'setupcon' from a virtual console.

ARG DEBIAN_FRONTEND=noninteractive

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt update && apt upgrade -y

RUN apt install -y systemd

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh
ENV LANG=ja_JP.UTF-8

RUN apt install -y libnotify4 libxkbfile1 libxss1
