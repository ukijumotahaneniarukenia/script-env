FROM centos:7.6.1810

ARG OS_VERSION
ARG REPO

ARG GIT_VERSION
ARG GRADLE_VERSION
ARG JAVA_VERSION
ARG MAVEN_VERSION
ARG PYTHON_VERSION

ENV LANG=ja_JP.UTF-8
ENV DISPLAY=:0.0

ENV JAVA_HOME=/usr/local/src/jdk-$JAVA_VERSION
ENV PATH=$JAVA_HOME/bin:$PATH
ENV GRADLE_HOME=/usr/local/src/gradle-$GRADLE_VERSION
ENV PATH=$GRADLE_HOME/bin:$PATH

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-docker-host-user.sh | bash

RUN cd /usr/local/src/$REPO && echo './$OS_VERSION-install-default-user.sh ' | bash

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-repository-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dev-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-tool-pkg.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-network-pkg.sh | bash

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-system.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-python-$PYTHON_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-git-$GIT_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-locale.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-ld.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font-RictyDiminished.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-fcitx_anthy.sh | bash

COPY subrun.sh /root/subrun.sh
#RUN bash /root/subrun.sh

COPY ideaIC-2019.2.4.tar.gz /usr/local/src/ideaIC-2019.2.4.tar.gz
RUN cd /usr/local/src && tar -xzf ideaIC-2019.2.4.tar.gz

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-jdk-$JAVA_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-maven-$MAVEN_VERSION.sh | bash

USER kuraine
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-vim-user.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-dotfile.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-env.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-config-font-RictyDiminished.sh | bash

WORKDIR /home/kuraine

COPY run.sh /etc/init/run.sh
ENTRYPOINT ["/etc/init/run.sh"]
