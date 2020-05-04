FROM ubuntu:19.10

ARG OS_VERSION
ARG APP_NAME
ARG REPO
ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_VERSION
ARG JAVA_VERSION
ARG MYSQL_VERSION
ARG PYTHON_VERSION

ENV LANG=ja_JP.UTF-8
ENV DISPLAY=:0.0

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y


RUN apt install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-docker-host-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-${APP_NAME:-default}-user.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-python-$PYTHON_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-pre-patch-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font-RictyDiminished.sh | bash

COPY mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb /usr/local/src/mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb
RUN apt install -y \
canberra-gtk* \
libatkmm-1.6-dev \
libcairo2-dev \
libgdk-pixbuf2.0-dev \
libglibmm-2.4-dev \
libgtk-3-dev \
libgtk2.0-dev \
libgtkmm-3.0-dev \
libmysqlclient21 \
libpangocairo-1.0-0 \
libpcrecpp0v5 \
libproj-dev \
libquazip5-dev \
libsecret-1-dev \
libsigc++-2.0-dev \
libxml2-dev \
libzip5 \
packagekit-gtk3-module \
proj-bin \
python2.7-dev
RUN export NO_AT_BRIDGE=1 && \
cd /usr/local/src && dpkg -i mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-jdk-$JAVA_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-mysql-$MYSQL_VERSION.sh | bash

USER mysql
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font-RictyDiminished.sh | bash

WORKDIR /home/mysql

