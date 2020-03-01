```
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=QseDt7167"    -p 1433:1433 --name sql1    -d mcr.microsoft.com/mssql/server:2019-GA-ubuntu-16.04


aine@centos ~/script-docker$exec env -it sql1 /bin/bash


mssql@9795d8760965:/$ cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync
games:x:5:60:games:/usr/games:/usr/sbin/nologin
man:x:6:12:man:/var/cache/man:/usr/sbin/nologin
lp:x:7:7:lp:/var/spool/lpd:/usr/sbin/nologin
mail:x:8:8:mail:/var/mail:/usr/sbin/nologin
news:x:9:9:news:/var/spool/news:/usr/sbin/nologin
uucp:x:10:10:uucp:/var/spool/uucp:/usr/sbin/nologin
proxy:x:13:13:proxy:/bin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
backup:x:34:34:backup:/var/backups:/usr/sbin/nologin
list:x:38:38:Mailing List Manager:/var/list:/usr/sbin/nologin
irc:x:39:39:ircd:/var/run/ircd:/usr/sbin/nologin
gnats:x:41:41:Gnats Bug-Reporting System (admin):/var/lib/gnats:/usr/sbin/nologin
nobody:x:65534:65534:nobody:/nonexistent:/usr/sbin/nologin
systemd-timesync:x:100:102:systemd Time Synchronization,,,:/run/systemd:/bin/false
systemd-network:x:101:103:systemd Network Management,,,:/run/systemd/netif:/bin/false
systemd-resolve:x:102:104:systemd Resolver,,,:/run/systemd/resolve:/bin/false
systemd-bus-proxy:x:103:105:systemd Bus Proxy,,,:/run/systemd:/bin/false
_apt:x:104:65534::/nonexistent:/bin/false
mssql:x:10001:0::/home/mssql:/bin/bash


mssql@9795d8760965:/opt/mssql-tools$ ls -lh
total 8.0K
drwxr-xr-x. 2 root root 4.0K Oct  9 18:58 bin
drwxr-xr-x. 3 root root 4.0K Oct  9 18:58 share
mssql@9795d8760965:/opt/mssql-tools$ cd bin
mssql@9795d8760965:/opt/mssql-tools/bin$ ls -lh
total 604K
-rwxr-xr-x. 1 root root 193K Jul 24  2019 bcp
-rwxr-xr-x. 1 root root 408K Jul 24  2019 sqlcmd
mssql@9795d8760965:/opt/mssql-tools/bin$ 



/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "QseDt7167"

1> select 1;
2> go
           
-----------
          1

(1 rows affected)

1> SELECT @@SERVERNAME;
2> go
                                                                                                                                
--------------------------------------------------------------------------------------------------------------------------------
9795d8760965                                                                                                                    

(1 rows affected)

1> CREATE DATABASE testdb;
2> go

1> SELECT Name from sys.Databases;
2> go
Name                                                                                                                            
--------------------------------------------------------------------------------------------------------------------------------
master                                                                                                                          
tempdb                                                                                                                          
model                                                                                                                           
msdb                                                                                                                            
testdb                                                                                                                          

(5 rows affected)

1> use testdb
2> go
Changed database context to 'testdb'.


1> CREATE TABLE Inventory (id INT, name NVARCHAR(50), quantity INT);
2> go
1> drop table Inventory;
2> go

1> INSERT INTO Inventory VALUES (1, 'banana', 150); INSERT INTO Inventory VALUES (2, 'orange', 154);
2> go

(1 rows affected)

(1 rows affected)


1> SELECT * FROM Inventory;
2> go
id          name                                               quantity   
----------- -------------------------------------------------- -----------
          1 banana                                                     150
          2 orange                                                     154

(2 rows affected)

1> quit
mssql@9795d8760965:/opt/mssql-tools$ 

3> use testdb
4> go
Changed database context to 'testdb'.
1> 
1> 
1> SELECT * FROM Inventory;
2> go
id          name                                               quantity   
----------- -------------------------------------------------- -----------
          1 banana                                                     150
          2 orange                                                     154

(2 rows affected)

Sqlcmd: Warning: The last operation was terminated because the user pressed CTRL+C.
mssql@9795d8760965:/opt/mssql-tools$ 


mssql@9795d8760965:/home$ cat /etc/os-release 
NAME="Ubuntu"
VERSION="16.04.6 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.6 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial

root@614a4df90429 /usr/local/src/script-repo$sqlcmd -S localhost -U SA -P "QseDt7167"
1> 
2> 
3> 
4> 
5> 
6> 
7> 
root@614a4df90429 /usr/local/src/script-repo$sqlcmd -S localhost -U SA -P "QseDt7167"
1> select @@version;
2> go
                                                                                                                                                                                                                                                                                                            
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Microsoft SQL Server 2019 (RTM) - 15.0.2000.5 (X64) 
	Sep 24 2019 13:48:23 
	Copyright (C) 2019 Microsoft Corporation
	Developer Edition (64-bit) on Linux (Ubuntu 16.04.6 LTS) <X64>                                                                                                                       

(1 rows affected)


mssqlパッチ

chown -R mssql:mssql /home/mssql
ln -fsr /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd

ubuntu-16-04-patch-mssql-15-0-2000-5.sh




RUN apt install -y libcurl4-gnutls-dev
```
