# トラシュー

- CREATED列の作成完了日時を見ると、24時間以内に作成されていないイメージがある。

```
$docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
ubuntu-19-10-keyboard-locale         latest              9b373ae65e26        6 hours ago         972MB
centos-7-6-18-10-postgres-perl       latest              7df6aa75e14d        6 hours ago         2.13GB
centos-7-6-18-10-postgres-python     latest              af6f6d426807        6 hours ago         2.14GB
centos-7-6-18-10-postgres-tcl        latest              8a7e64833426        6 hours ago         1.75GB
centos-7-6-18-10-postgres            latest              e2d846e9583e        6 hours ago         1.58GB
centos-7-6-18-10-anaconda-postgres   latest              21bcd9749fd0        7 hours ago         1.42GB
centos-7-6-18-10-fluentd             latest              8c4d580f84fb        7 hours ago         1.7GB
ubuntu-18-04-python-django-pycharm   latest              b052d8534a1f        7 hours ago         2.09GB
centos-7-6-18-10-nginx               latest              bb22ef7db4ec        7 hours ago         1.53GB
centos-7-6-18-10-apache              latest              009b522ed80c        7 hours ago         1.53GB
centos-7-6-18-10-sqlite              latest              cc57401e0756        7 hours ago         1.2GB
ubuntu-16-04-postgres-python         latest              9840e3ed9ff8        7 hours ago         999MB
centos-7-6-18-10-tcl                 latest              49c63bdc238a        7 hours ago         1.34GB
ubuntu-18-04-ibm-db2                 latest              1363a64371c5        7 hours ago         4.37GB
centos-7-6-18-10-ssh                 latest              6a1580d81e86        7 hours ago         501MB
ubuntu-16-04-gitlab                  latest              96b3ebbfd3aa        7 hours ago         1.91GB
ubuntu-19-10-wine                    latest              a322cb3562d0        7 hours ago         95.4MB
centos-7-6-18-10-systemd             latest              62897b3889d3        7 hours ago         258MB
ubuntu-19-10-go-vscode               latest              7f0c7dcb3c39        12 hours ago        2.76GB
centos-7-6-18-10-elastic-kibana      latest              a63de8d4c7d4        31 hours ago        3.54GB
centos-7-6-18-10-jenkins             latest              925b2682b38e        36 hours ago        2.43GB
ubuntu-18-04-swift-vscode            latest              da21626ab55f        37 hours ago        3.03GB
ubuntu-19-10-mysql-workbench         latest              490528a8d837        42 hours ago        2.52GB
centos-7-6-18-10-mysql-workbench     latest              10fba0256105        42 hours ago        5.34GB
gitlab/gitlab-ce                     latest              13d9da61e07d        3 days ago          1.85GB
centos-7-6-18-10-racket              latest              a847e5c5b001        3 days ago          4.36GB
centos-7-6-18-10-googler             latest              1b35d122bcdb        3 days ago          3.92GB
centos-7-6-18-10-jupyter             latest              8693dcdb62c2        3 days ago          3.78GB
ubuntu-19-10-c-cpp                   latest              1484a12fb06d        3 days ago          2.07GB
ubuntu-19-10-vim                     latest              cdba354d8fd2        3 days ago          2.07GB
centos-7-6-18-10-xsystemd            latest              8afa4e6f0af7        3 days ago          2.83GB
centos-7-6-18-10-c-cpp               latest              371891716282        3 days ago          5.23GB
centos-7-6-18-10-tex                 latest              3f4648f88a31        4 days ago          6.76GB
centos-7-6-18-10-egison              latest              a02017a73fee        4 days ago          9.46GB
centos-7-6-18-10-shiny-rstudio       latest              2876f93c5f82        8 days ago          3.49GB
centos                               latest              470671670cac        2 weeks ago         237MB
ubuntu                               19.10               dcbcfdcd50bb        2 weeks ago         72.9MB
ubuntu                               18.04               ccc6e87d482b        2 weeks ago         64.2MB
ubuntu                               16.04               c6a43cd4801e        6 weeks ago         123MB
ibmcom/db2                           latest              66a976f94954        6 months ago        2.96GB
centos                               7.6.1810            f1cb7c7d58b7        10 months ago       202MB
centos/systemd                       latest              05d3c1e2d0c1        13 months ago       202MB
```

- ログを確認してみる。
```
$cd ~/script_env
$grep 'No space left on device' -r .
./ubuntu-19-10-vim/log:/usr/bin/mandb: can't create index cache /var/cache/man/2815: No space left on device
./centos-7-6-18-10-go-vscode/log:fatal: could not create work tree dir '/home/kuraine/.vim'.: No space left on device
./ubuntu-19-10-tex/log:  Error writing to output file - write (28: No space left on device) [IP: 150.65.7.130 80]
./ubuntu-19-10-tex/log:  Error writing to output file - write (28: No space left on device) [IP: 150.65.7.130 80]
./ubuntu-19-10-tex/log:  Error writing to output file - write (28: No space left on device) [IP: 150.65.7.130 80]
./ubuntu-19-10-tex/log:  Error writing to output file - write (28: No space left on device) [IP: 150.65.7.130 80]
./ubuntu-19-10-tex/log:  Error writing to output file - write (28: No space left on device) [IP: 150.65.7.130 80]
./ubuntu-19-10-tex/log:  Error writing to output file - write (28: No space left on device) [IP: 150.65.7.130 80]
./ubuntu-19-10-c-cpp/log:/usr/bin/mandb: can't create index cache /var/cache/man/2815: No space left on device
```

- ディスク容量確認してみる。
```
$df -h
ファイルシス   サイズ  使用  残り 使用% マウント位置
devtmpfs          16G     0   16G    0% /dev
tmpfs             16G  219M   16G    2% /dev/shm
tmpfs             16G   43M   16G    1% /run
tmpfs             16G     0   16G    0% /sys/fs/cgroup
/dev/nvme0n1p3   451G  341G   88G   80% /
/dev/nvme0n1p1   3.7G  163M  3.3G    5% /boot
tmpfs            3.2G   44K  3.2G    1% /run/user/1000
```
- ファイル数を確認してみる。
```
$df -i
ファイルシス    Iノード   I使用    I残り I使用% マウント位置
devtmpfs        4076353     494  4075859     1% /dev
tmpfs           4080384     849  4079535     1% /dev/shm
tmpfs           4080384     922  4079462     1% /run
tmpfs           4080384      16  4080368     1% /sys/fs/cgroup
/dev/nvme0n1p3 30040064 2225234 27814830     8% /
/dev/nvme0n1p1   244320     349   243971     1% /boot
tmpfs           4080384      23  4080361     1% /run/user/1000
```
- これだ。
```
$cd ~/VirtualBox VMs/win10
$ls -lh
合計 206G
drwx------. 2 aine aine 4.0K  2月  1 20:30 Logs
drwx------. 2 aine aine 4.0K  2月  1 20:24 Snapshots
-rw-rw-r--. 1 aine aine 5.1G  2月  1 13:54 Win10_1909_Japanese_x64.iso
-rw-------. 1 aine aine  16K  2月  1 20:32 win10.vbox
-rw-------. 1 aine aine  16K  2月  1 20:32 win10.vbox-prev
-rw-------. 1 aine aine 201G  2月  1 17:05 win10.vhd
```

- VMの画面立ち上げて、画面から仮想ディスクを削除する。

```
$virtualbox
```

- isoイメージは残す。

```
$ls -lh
合計 5.1G
-rw-rw-r--. 1 aine aine 5.1G  2月  1 13:54 Win10_1909_Japanese_x64.iso
```

- 80%から30%になってくれた。
```
$df -h
ファイルシス   サイズ  使用  残り 使用% マウント位置
devtmpfs          16G     0   16G    0% /dev
tmpfs             16G  220M   16G    2% /dev/shm
tmpfs             16G   43M   16G    1% /run
tmpfs             16G     0   16G    0% /sys/fs/cgroup
/dev/nvme0n1p3   451G  129G  300G   30% /
/dev/nvme0n1p1   3.7G  163M  3.3G    5% /boot
tmpfs            3.2G   44K  3.2G    1% /run/user/1000
```
- ファイル数はそのまま。
```
$df -i
ファイルシス    Iノード   I使用    I残り I使用% マウント位置
devtmpfs        4076353     494  4075859     1% /dev
tmpfs           4080384     858  4079526     1% /dev/shm
tmpfs           4080384     924  4079460     1% /run
tmpfs           4080384      16  4080368     1% /sys/fs/cgroup
/dev/nvme0n1p3 30040064 2225226 27814838     8% /
/dev/nvme0n1p1   244320     349   243971     1% /boot
tmpfs           4080384      23  4080361     1% /run/user/1000
```

一旦これで様子見。

dockerイメージの容量削減は楽しみにとっておく。


# まちがって必要なファイル消した

- ブラウザでコミットハッシュ先頭7桁でHISTORYをたどって復元

```
$cd ~/script_env
$git log --name-status>a
$grep -P 'docker-build-parallel-retry.sh|Date' a
$grep -n -C10 -P 'Sun Feb 2 09:56:27' a
```
