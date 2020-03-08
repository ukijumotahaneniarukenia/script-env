FROM ubuntu:16.04

ARG OS_VERSION
ARG REPO
ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=ja_JP.UTF-8

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

RUN apt install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-default-env-usr.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
