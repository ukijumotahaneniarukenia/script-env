FROM ubuntu:19.10

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

#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0
