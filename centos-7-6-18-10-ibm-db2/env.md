```
PORTS=
```

```
VOLUMES=
```

```
docker run --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=db2_pwd -e DBNAME=testdb -v $(pwd):/database centos-7-6-18-10-ibm-db2 -it -name centos-7-6-18-10-ibm-db2
```
