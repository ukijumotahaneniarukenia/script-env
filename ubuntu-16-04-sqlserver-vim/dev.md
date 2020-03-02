# プロセス起動

```
TODO
```

# プロセス確認

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
mssql        1  0.1  0.0 148512 17144 pts/0    Ssl+ 21:32   0:00 /opt/mssql/bin/sqlservr
mssql        8  4.6  2.8 13022640 924252 pts/0 Sl+  21:32   0:14 /opt/mssql/bin/sqlservr
mssql      286  0.0  0.0  20900  2004 pts/1    Ss   21:38   0:00 /bin/bash
mssql      293  0.0  0.0  37084  1516 pts/1    R+   21:38   0:00 ps aux
```

# プロセス停止

```
TODO
```


# sqlservrコマンド

```
$/opt/mssql/bin/sqlservr --help
usage: sqlservr [OPTIONS...]

Configuration options:
  -T<#>                     Enable a traceflag
  -y<#>                     Enable dump when server encounters specified error
  -k<#>                     Checkpoint speed (in MB/sec)

Administrative options:
  --accept-eula             Accept the SQL Server EULA
  --pid <pid>               Set server product key
  --reset-sa-password       Reset system administrator password. Password should
                            be specified in the MSSQL_SA_PASSWORD environment
                            variable.
  -f                        Minimal configuration mode
  -m                        Single user administration mode
  -K                        Force regeneration of Service Master Key
  --setup                   Set basic configuration settings and then shutdown.
  --force-setup             Same as --setup, but also reinitialize master and model databases.

General options:
  -v                        Show program version
  --help                    Display this help information
```

# sqlcmdコマンド

これは自分でシンボリックリンクパッチ当てた



```
$which sqlcmd
/usr/local/bin/sqlcmd
$ls -lh /usr/local/bin/sqlcmd
lrwxrwxrwx. 1 root root 35  3月  2 21:01 /usr/local/bin/sqlcmd -> ../../../opt/mssql-tools/bin/sqlcmd
```

```
$sqlcmd -?
Microsoft (R) SQL Server Command Line Tool
Version 17.5.0001.2 Linux
Copyright (C) 2017 Microsoft Corporation. All rights reserved.

usage: sqlcmd            [-U login id]          [-P password]
  [-S server or Dsn if -D is provided]
  [-H hostname]          [-E trusted connection]
  [-N Encrypt Connection][-C Trust Server Certificate]
  [-d use database name] [-l login timeout]     [-t query timeout]
  [-h headers]           [-s colseparator]      [-w screen width]
  [-a packetsize]        [-e echo input]        [-I Enable Quoted Identifiers]
  [-c cmdend]
  [-q "cmdline query"]   [-Q "cmdline query" and exit]
  [-m errorlevel]        [-V severitylevel]     [-W remove trailing spaces]
  [-u unicode output]    [-r[0|1] msgs to stderr]
  [-i inputfile]         [-o outputfile]
  [-k[1|2] remove[replace] control characters]
  [-y variable length type display width]
  [-Y fixed length type display width]
  [-p[1] print statistics[colon format]]
  [-R use client regional setting]
  [-K application intent]
  [-M multisubnet failover]
  [-b On error batch abort]
  [-D Dsn flag, indicate -S is Dsn]
  [-X[1] disable commands, startup script, environment variables [and exit]]
  [-x disable variable substitution]
  [-g enable column encryption]
  [-G use Azure Active Directory for authentication]
  [-? show syntax summary]

```

# bcpコマンド

```
$/opt/mssql-tools/bin/bcp --help
usage: /opt/mssql-tools/bin/bcp {dbtable | query} {in | out | queryout | format} datafile
  [-m maxerrors]            [-f formatfile]          [-e errfile]
  [-F firstrow]             [-L lastrow]             [-b batchsize]
  [-n native type]          [-c character type]      [-w wide character type]
  [-N keep non-text native] [-q quoted identifier]
  [-t field terminator]     [-r row terminator]
  [-a packetsize]           [-K application intent]
  [-S server name or DSN if -D provided]             [-D treat -S as DSN]
  [-U username]             [-P password]
  [-T trusted connection]   [-v version]             [-R regional enable]
  [-k keep null values]     [-E keep identity values]
  [-h "load hints"]         [-d database name]
```

# sqlserverに接続

```
$sqlcmd -S localhost -U SA -P "QseDt7167"
```

# XXX

```
1> select 1;
2> go

-----------
          1

(1 rows affected)
1> SELECT @@SERVERNAME;
2> go

--------------------------------------------------------------------------------------------------------------------------------
42f186a04e1b

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
1> select @@version;
2> go

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Microsoft SQL Server 2019 (RTM) - 15.0.2000.5 (X64)
	Sep 24 2019 13:48:23
	Copyright (C) 2019 Microsoft Corporation
	Developer Edition (64-bit) on Linux (Ubuntu 16.04.6 LTS) <X64>

(1 rows affected)
1> drop table Inventory;
2> go
1> SELECT * FROM Inventory;
2> go
Msg 208, Level 16, State 1, Server 42f186a04e1b, Line 1
Invalid object name 'Inventory'.
````
