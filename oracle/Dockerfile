FROM centos:latest

RUN groupadd -g 54321 oinstall; && \
 groupadd -g 54322 dba; && \
 groupadd -g 54323 oper; && \
 groupadd -g 54324 backupdba; && \
 groupadd -g 54325 dgdba; && \
 groupadd -g 54326 kmdba; && \
 groupadd -g 54327 racdba; && \
 useradd -u 1200 -g oinstall -G dba,oper,backupdba,dgdba,kmdba,racdba -d /home/oracle oracle; && \
 mkdir -p /u01/app/oracle/product/19.0.0/dbhome_1; && \
 mkdir -p /u01/app/oraInventory; && \
 chown -R oracle:oinstall /u01/app/oracle; && \
 chown -R oracle:oinstall /u01/app/oraInventory; && \
 chmod -R g+w /u01

ENV ORACLE_BASE=/u01/app/oracle \
    ORACLE_HOME=/u01/app/oracle/product/19.0.0/dbhome_1 \
    ORA_INVENTORY=/u01/app/oraInventory \
    PATH=/u01/app/oracle/product/19.0.0/dbhome_1/bin:${PATH}

COPY LINUX.X64_193000_db_home.zip /LINUX.X64_193000_db_home.zip

RUN yum install -y unzip

#以下はrunInstaller実行後、処理する
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

#最後はrootに戻す
USER root 

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

CMD ["/sbin/init"]
