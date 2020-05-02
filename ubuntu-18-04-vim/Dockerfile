FROM ubuntu:18.04

ARG OS_VERSION
ARG REPO
ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=ja_JP.UTF-8

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

RUN groupadd -g 1000 aine && \
useradd -m -g aine -u 1000 aine && \
chsh -s /bin/bash aine && \
echo 'aine:aine_pwd' | chpasswd && \
echo 'aine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo 'root:root_pwd' | chpasswd

#RUN apt install -y git
#RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-docker-host-user.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-${APP_NAME:-default}-user.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-network-pkg.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
