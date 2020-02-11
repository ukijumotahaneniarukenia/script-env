FROM centos:7.6.1810

ARG CONTAINER_NAME
ARG OS_VERSION
ARG GIT_VERSION
ARG PYTHON_VERSION

RUN groupadd -g 1002 td-agent && \
useradd -m -g td-agent -u 1002 td-agent && \
chsh -s /bin/bash td-agent && \
echo 'td-agent_pwd' | passwd --stdin td-agent && \
echo 'td-agent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN groupadd -g 1003 nginx && \
useradd -m -g nginx -u 1003 nginx && \
chsh -s /bin/bash nginx && \
echo 'nginx_pwd' | passwd --stdin nginx && \
echo 'nginx ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script-repo.git
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-python-$PYTHON_VERSION.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-fluentd.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-nginx.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

USER nginx
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
USER td-agent
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

#nginxサービス外部公開ポート
EXPOSE 80

WORKDIR /home/td-agent
