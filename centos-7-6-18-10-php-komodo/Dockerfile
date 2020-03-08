FROM centos:7.6.1810

ARG OS_VERSION
ARG REPO
ARG GIT_VERSION
ARG PYTHON_VERSION
ARG PHP_VERSION

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-default-env-usr.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-python-$PYTHON_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-php-$PHP_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

#komodoインストール
COPY Komodo-Edit-11.1.1-18206-linux-x86_64.tar.gz /usr/local/src/Komodo-Edit-11.1.1-18206-linux-x86_64.tar.gz
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-komodo-11-1-1.sh | bash

#XクライアントがXサーバーにGUI転送出来るように、転送先の「IP:ディスプレイ番号:スクリーン番号」を指定する
ENV DISPLAY=:0.0

USER kuraine
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font.sh | bash

WORKDIR /home/kuraine
