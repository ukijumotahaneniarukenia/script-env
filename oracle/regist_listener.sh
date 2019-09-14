#!/bin/bash

echo "ORCLPDB@ = (DESCRIPTION = (ADDRESS = (PROTOCOL = TCP)(HOST = be807f28f5bd)(PORT = 1521)) (CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = ORCLPDB@)))" | parallel echo :::: - <(seq 2) | awk '{$NF="";RN=sprintf("%02d",NR);print "echo \x22"$0"\x22 | sed -E \x27s;@;"RN";g\x27"}' | bash >> /opt/oracle/product/19c/dbhome_1/network/admin/tnsnames.ora
