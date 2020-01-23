# 参考文献

https://www.ibm.com/support/producthub/db2/docs/content/SSEPGG_11.5.0/com.ibm.db2.luw.qb.server.doc/doc/t0008875.html

https://www.ibmbigdatahub.com/blog/simplifying-db2-downloads-help-clients-and-developers-get-started?_ga=2.116263366.1982163311.1579705509-1850039665.1572074127&cm_mc_uid=89503398108915720741268&cm_mc_sid_50200000=74238601579705509031


docker run --privileged --shm-size=8gb --name ubuntu-db2 -itd -v /tmp/.X11-unix:/tmp/.X11-unix  ubuntu_db2

docker exec -it ubuntu-db2 /bin/bash
