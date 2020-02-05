dockerの作成時刻これにする
```
docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2
```


```
ubuntu-19-10-tex 2020-02-06T02:54:51+09:00
centos-7-6-18-10-egison 2020-02-06T02:44:20+09:00
centos-7-6-18-10-racket 2020-02-06T02:38:01+09:00
centos-7-6-18-10-googler 2020-02-06T02:37:34+09:00
centos-7-6-18-10-jupyter 2020-02-06T02:34:40+09:00
ubuntu-19-10-mysql-workbench 2020-02-06T02:33:02+09:00
ubuntu-19-10-go-vscode 2020-02-06T02:32:39+09:00
centos-7-6-18-10-xsystemd 2020-02-06T02:30:19+09:00
ubuntu-18-04-swift-vscode 2020-02-06T02:27:48+09:00
ubuntu-19-10-c-cpp 2020-02-06T02:27:19+09:00
centos-7-6-18-10-elastic-kibana 2020-02-06T02:19:16+09:00
ubuntu-19-10-keyboard-locale 2020-02-06T01:27:44+09:00
centos-7-6-18-10-postgres-perl 2020-02-06T02:12:02+09:00
centos-7-6-18-10-c-cpp 2020-02-06T02:11:05+09:00
centos-7-6-18-10-jenkins 2020-02-06T02:10:35+09:00
centos-7-6-18-10-postgres-tcl 2020-02-06T02:09:51+09:00
centos-7-6-18-10-anaconda-postgres 2020-02-06T02:00:45+09:00
centos-7-6-18-10-apache 2020-02-06T01:53:21+09:00
ubuntu-18-04-python-django-pycharm 2020-02-06T01:51:08+09:00
centos-7-6-18-10-nginx 2020-02-06T01:47:08+09:00
centos-7-6-18-10-sqlite 2020-02-06T01:46:24+09:00
ubuntu-16-04-postgres-python 2020-02-06T01:45:38+09:00
centos-7-6-18-10-postgres 2020-02-06T01:45:33+09:00
centos-7-6-18-10-tcl 2020-02-06T01:33:16+09:00
centos-7-6-18-10-ssh 2020-02-06T01:20:41+09:00
ubuntu-16-04-gitlab 2020-02-06T01:20:27+09:00
ubuntu-19-10-wine 2020-02-06T01:13:06+09:00
centos-7-6-18-10-systemd 2020-02-06T01:12:11+09:00
ubuntu-19-10-vim 2020-02-05T02:22:52+09:00
centos-7-6-18-10-go-vscode 2020-02-05T02:14:08+09:00
centos-7-6-18-10-postgres-python 2020-02-05T02:01:11+09:00
centos-7-6-18-10-fluentd 2020-02-05T01:40:35+09:00
centos-7-6-18-10-mysql-workbench 2020-02-02T14:21:54+09:00
centos-7-6-18-10-tex 2020-01-31T07:58:09+09:00
centos-7-6-18-10-shiny-rstudio 2020-01-26T12:46:17+09:00
centos-7-6-18-10-ibm-db2 2019-07-12T21:53:24+09:00
```


```
aine@centos ~/script_env$docker images | grep -P '(?:-[0-9]){1,}' | awk '{print $1}' | xargs -I@ bash -c "echo @ && docker history --human=false @ | sort -rk2 | sed -r 's;\s{1,}; ;g;' | cut -d' ' -f2 | sed -n '2p'" | xargs -n2 | nl
     1	ubuntu-19-10-tex 2020-02-06T02:54:51+09:00
     2	centos-7-6-18-10-egison 2020-02-06T02:44:20+09:00
     3	centos-7-6-18-10-racket 2020-02-06T02:38:01+09:00
     4	centos-7-6-18-10-googler 2020-02-06T02:37:34+09:00
     5	centos-7-6-18-10-jupyter 2020-02-06T02:34:40+09:00
     6	ubuntu-19-10-mysql-workbench 2020-02-06T02:33:02+09:00
     7	ubuntu-19-10-go-vscode 2020-02-06T02:32:39+09:00
     8	centos-7-6-18-10-xsystemd 2020-02-06T02:30:19+09:00
     9	ubuntu-18-04-swift-vscode 2020-02-06T02:27:48+09:00
    10	ubuntu-19-10-c-cpp 2020-02-06T02:27:19+09:00
    11	centos-7-6-18-10-elastic-kibana 2020-02-06T02:19:16+09:00
    12	ubuntu-19-10-keyboard-locale 2020-02-06T01:27:44+09:00
    13	centos-7-6-18-10-postgres-perl 2020-02-06T02:12:02+09:00
    14	centos-7-6-18-10-c-cpp 2020-02-06T02:11:05+09:00
    15	centos-7-6-18-10-jenkins 2020-02-06T02:10:35+09:00
    16	centos-7-6-18-10-postgres-tcl 2020-02-06T02:09:51+09:00
    17	centos-7-6-18-10-anaconda-postgres 2020-02-06T02:00:45+09:00
    18	centos-7-6-18-10-apache 2020-02-06T01:53:21+09:00
    19	ubuntu-18-04-python-django-pycharm 2020-02-06T01:51:08+09:00
    20	centos-7-6-18-10-nginx 2020-02-06T01:47:08+09:00
    21	centos-7-6-18-10-sqlite 2020-02-06T01:46:24+09:00
    22	ubuntu-16-04-postgres-python 2020-02-06T01:45:38+09:00
    23	centos-7-6-18-10-postgres 2020-02-06T01:45:33+09:00
    24	centos-7-6-18-10-tcl 2020-02-06T01:33:16+09:00
    25	centos-7-6-18-10-ssh 2020-02-06T01:20:41+09:00
    26	ubuntu-16-04-gitlab 2020-02-06T01:20:27+09:00
    27	ubuntu-19-10-wine 2020-02-06T01:13:06+09:00
    28	centos-7-6-18-10-systemd 2020-02-06T01:12:11+09:00
    29	ubuntu-19-10-vim 2020-02-05T02:22:52+09:00
    30	centos-7-6-18-10-go-vscode 2020-02-05T02:14:08+09:00
    31	centos-7-6-18-10-postgres-python 2020-02-05T02:01:11+09:00
    32	centos-7-6-18-10-fluentd 2020-02-05T01:40:35+09:00
    33	centos-7-6-18-10-mysql-workbench 2020-02-02T14:21:54+09:00
    34	centos-7-6-18-10-tex 2020-01-31T07:58:09+09:00
    35	centos-7-6-18-10-shiny-rstudio 2020-01-26T12:46:17+09:00
    36	centos-7-6-18-10-ibm-db2 2019-07-12T21:53:24+09:00
```
