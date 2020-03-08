FROM ubuntu:19.10

ARG OS_VERSION
ARG REPO
ARG GIT_VERSION
ARG PYTHON_VERSION
ARG JAVA_VERSION
ARG APACHE_SOLR_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

RUN apt install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-java-apache-solr-vim-env-usr.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-default-env-usr.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-jdk-$JAVA_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-apache-solr-$APACHE_SOLR_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

USER solr
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash

#apache-solrサービス外部公開ポート
EXPOSE 8983

WORKDIR /home/solr
