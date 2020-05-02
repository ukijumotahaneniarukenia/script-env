FROM ibmcom/db2

# set License to accept to use the Db2 software contained in this image
ENV LICENSE=accept
# specify the Db2 Instance name
ENV DB2INSTANCE=db2inst1
# specify the Db2 Instance password
ENV DB2INST1_PASSWORD=hogehoge
# create an initial database with the name provided or leave empty
ENV DBNAME=testdb
# set to true to enable BLU on instance
ENV BLU=false
# set to true to enable Oracle Compatibility on instance
ENV ENABLE_ORACLE_COMPATIBILITY=true
# set to true to create sample database
ENV SAMPLEDB=true

ARG GIT_VERSION
ARG PYTHON_VERSION

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-docker-host-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-ibm-db2-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-${APP_NAME:-default}-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-network-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-python-$PYTHON_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-c-cpp.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
ENV LANG=ja_JP.UTF-8

USER db2fenc1
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash

USER db2inst1
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash

WORKDIR /home/kuraine

EXPOSE 50000
