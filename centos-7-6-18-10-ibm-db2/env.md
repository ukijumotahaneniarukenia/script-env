PORTS=
VOLUMES=
docker run -itd --name mydb2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=db2_pwd -e DBNAME=testdb -v $(pwd):/database ubuntu-18-04-ibm-db2
