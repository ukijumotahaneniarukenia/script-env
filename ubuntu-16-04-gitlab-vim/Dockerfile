FROM gitlab/gitlab-ce:latest

ARG OS_VERSION
ARG REPO
ARG GIT_VERSION
ARG PYTHON_VERSION

ARG DEBIAN_FRONTEND=noninteractive

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

RUN apt install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-gitlab-vim-env-usr.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-default-env-usr.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-python-$PYTHON_VERSION.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-system.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash

USER gitlab
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
#RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash

#gitlab環境変数の設定
ENV GITLAB_OMNIBUS_CONFIG="external_url 'http://localhost:9010';gitlab_rails['gitlab_shell_ssh_port'] = 2022;"

#gitlabサービス外部公開ポート
EXPOSE 9010
EXPOSE 2022

WORKDIR /home/gitlab
