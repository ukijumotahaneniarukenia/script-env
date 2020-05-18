#!/usr/bin/env bash

yum install -y https://packages.groonga.org/centos/groonga-release-latest.noarch.rpm

yum install -y http://repo.mysql.com/mysql80-community-release-el7.rpm

yum install -y --enablerepo=epel mysql80-community-mroonga

#これはむりだった
#expect -c "
#spawn yum install -y --enablerepo=epel mysql80-community-mroonga
#expect \"Enter password:\"
#send -- \"\n\"
#expect \"Enter password:\"
#send -- \"\n\"
#"
