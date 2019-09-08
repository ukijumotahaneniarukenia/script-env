FROM centso:latest

RUN { echo "LISTENER = ";\
      echo "(DESCRIPTION_LIST = ";\
      echo "  (DESCRIPTION = ";\
      echo "    (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1)) ";\
      echo "    (ADDRESS = (PROTOCOL = TCP)(HOST = 0.0.0.0)(PORT = 1521)) ";\
      echo "  ) ";\
      echo ") ";\
      echo "USE_SID_AS_SERVICE_listener=on";\
      echo "INBOUND_CONNECT_TIMEOUT_LISTENER=400";\
    } >> ${ORACLE_HOME}/network/admin/listener.ora

CMD ["/sbin/init"]
