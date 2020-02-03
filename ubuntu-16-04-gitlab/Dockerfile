FROM gitlab/gitlab-ce:latest

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

#対話入力無視
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y

RUN apt install -y systemd apt-utils

#タイムゾーンの設定（この設定は最初にもってくる。対話入力避けるため。）
RUN apt install -y tzdata && ln -fsr /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
#日本語環境
RUN apt install -y locales && locale-gen ja_JP.UTF-8 && echo 'export LANG=ja_JP.UTF-8' >> /etc/profile.d/99-locale-ja.sh
ENV LANG=ja_JP.UTF-8

#gitlab環境変数の設定
ENV GITLAB_OMNIBUS_CONFIG="external_url 'http://localhost:9010';gitlab_rails['gitlab_shell_ssh_port'] = 2022;"

#gitlabサービス外部公開ポート
EXPOSE 9010
EXPOSE 2022
