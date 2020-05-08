FROM mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04

ARG OS_VERSION
ARG APP_NAME
ARG REPO
ARG DEBIAN_FRONTEND=noninteractive

ARG GIT_VERSION
ARG PYTHON_VERSION
ARG SQLSERVER_VERSION

ENV LANG=ja_JP.UTF-8
ENV DISPLAY=:0.0

ENV ACCEPT_EULA=Y
ENV SA_PASSWORD=QseDt7167

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

#ENV ACCEPT_EULA=Y
#ENV SA_PASSWORD=QseDt7167

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
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-fcitx_mozc.sh | bash

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-pre-patch-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-patch-sqlserver-$SQLSERVER_VERSION.sh | bash

USER mssql
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font-RictyDiminished.sh | bash

WORKDIR /home/mssql

EXPOSE 1433
COPY run.sh /etc/init/run.sh
ENTRYPOINT ["/etc/init/run.sh"]
