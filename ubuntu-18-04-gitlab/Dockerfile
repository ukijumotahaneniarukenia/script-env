FROM ubuntu:18.04

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

#対話入力無視
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

RUN apt install -y systemd

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh
ENV LANG=ja_JP.UTF-8

#gitlabイントール
RUN apt-get install -y curl openssh-server ca-certificates
RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y postfix
RUN curl -Ss https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | bash
RUN apt install -y gitlab-ce
RUN gitlab-ctl reconfigure
