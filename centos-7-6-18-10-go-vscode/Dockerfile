FROM centos:7.6.1810

ARG CONTAINER_NAME
ARG OS_VERSION

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo 'root_pwd' | passwd --stdin root

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-python-3-7-4.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-go-1-13-5 | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-git.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

#XクライアントがXサーバーにGUI転送出来るように、転送先の「IP:ディスプレイ番号:スクリーン番号」を指定する
ENV DISPLAY=:0.0

#vscodeインストール
COPY code-1.41.1-1576681965.el7.x86_64.rpm /usr/local/src/code-1.41.1-1576681965.el7.x86_64.rpm
RUN cd /usr/local/src && yum install -y code-1.41.1-1576681965.el7.x86_64.rpm

USER kuraine
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-font.sh | bash

WORKDIR /home/kuraine
