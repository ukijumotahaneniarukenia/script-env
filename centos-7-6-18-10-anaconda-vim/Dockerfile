FROM centos:7.6.1810

ARG CONTAINER_NAME
ARG OS_VERSION
ARG GIT_VERSION

RUN groupadd -g 1001 anacon && \
useradd -m -g anacon -u 1001 anacon && \
chsh -s /bin/bash anacon && \
echo 'anacon_pwd' | passwd --stdin anacon && \
echo 'anacon ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo 'root_pwd' | passwd --stdin root

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

USER anacon
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

WORKDIR /home/anacon
