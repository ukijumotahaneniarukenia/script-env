FROM centos:latest

RUN groupadd -g 54321 oinstall && \
 groupadd -g 54322 dba && \
 groupadd -g 54323 oper && \
 groupadd -g 54324 backupdba && \
 groupadd -g 54325 dgdba && \
 groupadd -g 54326 kmdba && \
 groupadd -g 54327 racdba && \
 useradd -u 1200 -g oinstall -G dba,oper,backupdba,dgdba,kmdba,racdba -d /home/oracle oracle && \
 mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1 && \
 mkdir -p /u01/app/oraInventory

ENV ORACLE_BASE=/u01/app/oracle \
    ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1 \
    ORA_INVENTORY=/u01/app/oraInventory \
    PATH=/u01/app/oracle/product/19.0.0/dbhome_1/bin:${PATH} \
    LD_LIBRARY_PATH=/u01/app/oracle/product/19.0.0/dbhome_1/lib \
    SOFTWARE="LINUX.X64_193000_db_home.zip" \
    PASSWORD="ORACLE_PWD" \
    ORACLE_SID="ORCL" \
    PDB_NAME="PDB1"

RUN yum install -y unzip make gcc libaio

COPY ${SOFTWARE} /${SOFTWARE}

RUN unzip -d ${ORACLE_HOME} /${SOFTWARE} && \
 chown -R oracle:oinstall /u01/app/oracle && \
 chown -R oracle:oinstall /u01/app/oraInventory && \
 chmod -R g+w /u01

# runInstallerはoracleユーザーで実行
USER oracle
# レスポンスファイルはダミーで指定
RUN ${ORACLE_HOME}/runInstaller -ignorePrereq                                  \
    -waitforcompletion -silent                                                 \
    -responseFile ${ORACLE_HOME}/install/response/db_install.rsp               \
    oracle.install.option=INSTALL_DB_SWONLY                                    \
    ORACLE_HOSTNAME=$(hostname)                                                \
    UNIX_GROUP_NAME=dba                                                        \
    INVENTORY_LOCATION=${ORA_INVENTORY}                                        \
    ORACLE_HOME=${ORACLE_HOME}                                                 \
    ORACLE_BASE=${ORACLE_BASE}                                                 \
    oracle.install.db.InstallEdition=EE                                        \
    oracle.install.db.OSDBA_GROUP=dba                                          \
    oracle.install.db.OSBACKUPDBA_GROUP=dba                                    \
    oracle.install.db.OSDGDBA_GROUP=dba                                        \
    oracle.install.db.OSKMDBA_GROUP=dba                                        \
    oracle.install.db.OSRACDBA_GROUP=dba                                       \
    SECURITY_UPDATES_VIA_MYORACLESUPPORT=false                                 \
    DECLINE_SECURITY_UPDATES=true; exit 0

# ログよりrootで実行
#As a root user, execute the following script(s):
#	1. /u01/app/oraInventory/orainstRoot.sh
#	2. /u01/app/oracle/product/19.0.0/dbhome_1/root.sh

USER root
RUN sh ${ORA_INVENTORY}/orainstRoot.sh                                      && \
    sh ${ORACLE_HOME}/root.sh

# dbcaはoracleユーザーで実行
USER oracle
RUN dbca -silent -createDatabase                                                 \
    -templateName General_Purpose.dbc                                          \
    -gdbname ${ORACLE_SID} -sid ${ORACLE_SID} -responseFile NO_VALUE           \
    -characterSet AL32UTF8                                                     \
    -sysPassword ${PASSWORD}                                               \
    -systemPassword ${PASSWORD}                                            \
    -createAsContainerDatabase true                                            \
    -numberOfPDBs 1                                                            \
    -pdbName ${PDB_NAME}                                                       \
    -pdbAdminPassword ${PASSWORD}                                          \
    -databaseType MULTIPURPOSE                                                 \
    -automaticMemoryManagement false                                           \
    -totalMemory 1536                                                          \
    -storageType FS                                                            \
    -datafileDestination "/u01/app/oraInventory"                                        \
    -redoLogFileSize 50                                                        \
    -emConfiguration NONE                                                      \
    -ignorePreReqs


#以下のリスナー関連ファイルはoracleユーザーで作成
#USER oracle
#RUN { echo "LISTENER = ";\
#      echo "(DESCRIPTION_LIST = ";\
#      echo "  (DESCRIPTION = ";\
#      echo "    (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1)) ";\
#      echo "    (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521)) ";\
#      echo "  ) ";\
#      echo ") ";\
#      echo "USE_SID_AS_SERVICE_listener=on";\
#      echo "INBOUND_CONNECT_TIMEOUT_LISTENER=400";\
#    } >> ${ORACLE_HOME}/network/admin/listener.ora
#
#RUN { echo "LISTENER = (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521))";\
#      echo "${ORACLE_SID}= ";\
#      echo "(DESCRIPTION = ";\
#      echo "  (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521))";\
#      echo "  (CONNECT_DATA =";\
#      echo "    (SERVER = DEDICATED)";\
#      echo "    (SERVICE_NAME = ${ORACLE_SID})";\
#      echo "  )";\
#      echo ")";\
#      echo "${PDB_NAME}= ";\
#      echo "(DESCRIPTION = ";\
#      echo "  (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521))";\
#      echo "  (CONNECT_DATA =";\
#      echo "    (SERVER = DEDICATED)";\
#      echo "    (SERVICE_NAME = ${PDB_NAME})";\
#      echo "  )";\
#      echo ")";\
#    } >> ${ORACLE_HOME}/network/admin/tnsnames.ora
#
#RUN echo "SQLNET.INBOUND_CONNECT_TIMEOUT=400" >> ${ORACLE_HOME}/network/admin/sqlnet.ora
#
##リスナー起動
#RUN lsnrctl start

#最後はrootに戻す
USER root 

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

USER oracle

CMD ["/sbin/init"]
