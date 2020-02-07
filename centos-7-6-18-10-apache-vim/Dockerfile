FROM centos:7.6.1810

ARG CONTAINER_NAME
ARG OS_VERSION

RUN groupadd -g 1001 apache && \
useradd -m -g apache -u 1001 apache && \
chsh -s /bin/bash apache && \
echo 'apache_pwd' | passwd --stdin apache && \
echo 'apache ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo 'root_pwd' | passwd --stdin root

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/script_repo.git
RUN cd /usr/local/src/script_repo && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/script_repo && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/script_repo && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/script_repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script_repo && echo ./$OS_VERSION-config-locale.sh | bash
ENV LANG=ja_JP.UTF-8

#apache-httpdインストール
RUN yum install -y httpd
RUN chown -R apache:apache /var/www && chmod 755 /var/www

USER apache
RUN cd /usr/local/src/script_repo && echo ./$OS_VERSION-install-vim-user.sh | bash

WORKDIR /home/apache

#httpdサービス外部公開ポート
EXPOSE 80
