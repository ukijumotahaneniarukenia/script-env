FROM centos:7.6.1810

ARG CONTAINER_NAME
ARG OS_VERSION
ARG GIT_VERSION
ARG PYTHON_VERSION
ARG JAVA_VERSION

RUN groupadd -g 1001 jenkins && \
useradd -m -g jenkins -u 1001 jenkins && \
chsh -s /bin/bash jenkins && \
echo 'jenkins_pwd' | passwd --stdin jenkins && \
echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
echo 'root_pwd' | passwd --stdin root

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
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-jdk-$JAVA_VERSION.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-jenkins.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

USER jenkins
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/script-repo && echo ./$OS_VERSION-config-env.sh | bash

#jenkinsサービス外部公開ポート
EXPOSE 8080

WORKDIR /home/jenkins
