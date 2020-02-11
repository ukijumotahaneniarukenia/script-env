FROM centos:7.6.1810

ARG CONTAINER_NAME
ARG OS_VERSION
ARG GIT_VERSION
ARG PYTHON_VERSION

RUN groupadd -g 991 elasticsearch && \
useradd -m -g elasticsearch -u 994 elasticsearch && \
chsh -s /bin/bash elasticsearch && \
echo 'elasticsearch_pwd' | passwd --stdin elasticsearch && \
echo 'elasticsearch ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN groupadd -g 990 kibana && \
useradd -m -g kibana -u 993 kibana && \
chsh -s /bin/bash kibana && \
echo 'kibana_pwd' | passwd --stdin kibana && \
echo 'kibana ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

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
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-jdk11.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

#elasticsearchインストール
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-elasticsearch-7-5-1.sh | bash

#kibanaインストール
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-kibana-7-5-1.sh | bash

USER kibana
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
USER elasticsearch
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

#elasticサービス外部公開ポート
EXPOSE 9200
#kibanaサービス外部公開ポート
EXPOSE 5601

WORKDIR /home/elasticsearch
