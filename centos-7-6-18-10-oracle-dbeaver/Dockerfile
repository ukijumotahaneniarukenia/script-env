FROM centos:7.6.1810

ARG OS_VERSION
ARG REPO

ARG GIT_VERSION
ARG PYTHON_VERSION

ENV LANG=ja_JP.UTF-8
ENV DISPLAY=:0.0

RUN yum install -y git
RUN cd /usr/local/src && git clone https://github.com/ukijumotahaneniarukenia/$REPO.git

RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-docker-host-user.sh

USER root

RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-repository-pkg.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-dev-pkg.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-tool-pkg.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-network-pkg.sh

RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim-system.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim-user.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim_plug.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-python-$PYTHON_VERSION.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-git-$GIT_VERSION.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-dotfile.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-locale.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-env.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-ld.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-font-RictyDiminished.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-ibus_mozc.sh
#RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-fcitx_anthy.sh

ENV ORACLE_DOCKER_INSTALL=true
ENV ORACLE_SID=ORCLCDB
ENV ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
ENV PATH=$PATH:$ORACLE_HOME/bin

RUN cd /usr/local/src && curl -sSLO https://yum.oracle.com/repo/OracleLinux/OL7/latest/x86_64/getPackage/oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm
RUN cd /usr/local/src && yum -y localinstall oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm && rm oracle-database-preinstall-19c-1.0-1.el7.x86_64.rpm

COPY oracle-database-ee-19c-1.0-1.x86_64.rpm /root/oracle-database-ee-19c-1.0-1.x86_64.rpm
RUN yum -y localinstall /root/oracle-database-ee-19c-1.0-1.x86_64.rpm

#起動スクリプトの微修正
RUN sed -i '34i export PASSWORD=ORACLE_PWD' /etc/init.d/oracledb_ORCLCDB-19c
RUN sed -i '165s;^;#;' /etc/init.d/oracledb_ORCLCDB-19c
RUN sed -i '166i $SU -s /bin/bash  $ORACLE_OWNER -c "$DBCA -silent -createDatabase -gdbName $ORACLE_SID -templateName $TEMPLATE_NAME -characterSet $CHARSET -createAsContainerDatabase $CREATE_AS_CDB -createListener $LISTENER_NAME:$LISTENER_PORT -datafileDestination $ORACLE_DATA_LOCATION -sid $ORACLE_SID -sysPassword $PASSWORD -systemPassword $PASSWORD -emConfiguration DBEXPRESS -emExpressPort $EM_EXPRESS_PORT"' /etc/init.d/oracledb_ORCLCDB-19c

#パスワード変更
RUN echo 'oracle:oracle_pwd' | chpasswd

#準備が大変だな
COPY create_user.sql /home/oracle/create_user.sql
COPY glogin.sql /opt/oracle/product/19c/dbhome_1/sqlplus/admin/glogin.sql
COPY init_db.sh /home/oracle/init_db.sh
COPY launch_and_open_db.sql /home/oracle/launch_and_open_db.sql
RUN chown oracle:oinstall /home/oracle/* && chmod +x /home/oracle/*

RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-dbeaver-$DBEAVER_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-jdk-$JAVA_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && echo ./$OS_VERSION-install-maven-$MAVEN_VERSION.sh | bash
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-default-user.sh 1000 aine 1000 aine aine_pwd

USER aine
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim-user.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-install-vim_plug.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-dotfile.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-env.sh
RUN cd /usr/local/src/$REPO && bash $OS_VERSION-config-font-RictyDiminished.sh

WORKDIR /home/aine

EXPOSE 1521

COPY env-run.sh /etc/init/env-run.sh
ENTRYPOINT ["/etc/init/env-run.sh","centos"]

