
# Dockerfileよりイメージ作成
```
time docker build -t centos_ssh . | tee log
```

# dockerコンテナ作成
```
docker run --privileged -v $(pwd):/root -v /etc/localtime:/etc/localtime -p 10022:22 --name ssh -itd centos_ssh /sbin/init
```

# dockerコンテナ削除
```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除
```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ潜入
```
docker exec --user root -it httpd /bin/bash
docker exec --user apache -it httpd /bin/bash
```

# サービス起動確認
```
systemctl status httpd
systemctl start httpd
```

## dockerホスト側からdockerコンテナ側にssh接続する検証コンテナ作成の手順

### dockerホストで公開鍵と秘密鍵作成
```
[rstudio@centos ~]$ssh-keygen -t rsa
Generating public/private rsa key pair.
Enter file in which to save the key (/home/rstudio/.ssh/id_rsa): 
Created directory '/home/rstudio/.ssh'.
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/rstudio/.ssh/id_rsa.
Your public key has been saved in /home/rstudio/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:/emrm293mqJy/n6xGwPYFkrBSuVa4AorGH18fSDyVmc rstudio@centos
The key's randomart image is:
+---[RSA 2048]----+
|    . . +oE      |
| . . o =.*..     |
|. . + +.o.= .    |
| o . = ..* + .   |
|. . . . S + +    |
|   .       o o.  |
|            o oo |
|        . .oo ++.|
|         +*O*=++ |
+----[SHA256]-----+
```

### dockerホスト側で作成した公開鍵をsshサーバーの~/.sshに配備
配備先はdocker起動時に指定したホスト側のマウントディれくトリに配備
```
[rstudio@centos ~/.ssh]$ll
合計 8
-rw-------. 1 rstudio rstudio 1675  8月 25 18:57 id_rsa
-rw-r--r--. 1 rstudio rstudio  396  8月 25 18:57 id_rsa.pub
[rstudio@centos ~/.ssh]$cp id_rsa.pub  ~/unko/id_rsa.pub
[rstudio@centos ~/unko]$ls
Dockerfile  id_rsa.pub  log
```

### dockerコンテナ側でdockerホストで作成した公開鍵がマウントされてきているか確認
```
[rstudio@centos ~/unko]$docker exec --user root -it ssh bash
bash-4.2# whoami
root
bash-4.2# cd ~
bash-4.2# pwd
/root
bash-4.2# ls -la
total 56
drwxrwxr-x. 2 1001 1003  4096 Aug 25 19:03 .
drwxr-xr-x. 1 root root  4096 Aug 25 18:52 ..
-rw-rw-r--. 1 1001 1003   503 Aug 25 17:57 Dockerfile
-rw-r--r--. 1 1001 1003   396 Aug 25 19:00 id_rsa.pub
-rw-rw-r--. 1 1001 1003 35575 Aug 25 17:58 log
```

### dockerコンテナ側でsshdサービスが起動しているか確認
```
bash-4.2# systemctl status sshd
● sshd.service - OpenSSH server daemon
   Loaded: loaded (/usr/lib/systemd/system/sshd.service; enabled; vendor preset: enabled)
   Active: active (running) since Sun 2019-08-25 18:51:59 JST; 12min ago
     Docs: man:sshd(8)
           man:sshd_config(5)
 Main PID: 2282 (sshd)
   CGroup: /docker/f8456ba46f92eb16dfb85647c2b4c846a6189d4ce99bb7cfae3757ac8ce2bd6b/system.slice/sshd.service
           └─2282 /usr/sbin/sshd -D
           ‣ 2282 /usr/sbin/sshd -D

Aug 25 18:51:59 f8456ba46f92 systemd[1]: Starting OpenSSH server daemon...
Aug 25 18:51:59 f8456ba46f92 sshd[2282]: Server listening on 0.0.0.0 port 22.
Aug 25 18:51:59 f8456ba46f92 sshd[2282]: Server listening on :: port 22.
Aug 25 18:51:59 f8456ba46f92 systemd[1]: Started OpenSSH server daemon.
```

### dockerコンテナのip確認
172.17.0.2のようだ。
```
bash-4.2# ip a show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
170: eth0@if171: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```

### dockerホスト側からdockerコンテナ側にssh接続
```
[rstudio@centos ~/unko]$ssh root@172.17.0.2
The authenticity of host '172.17.0.2 (172.17.0.2)' can't be established.
ECDSA key fingerprint is SHA256:GuPaxShSlhJ0Y/MY99T+JcdIsmkCnA+Lnl0JkFqaOLA.
ECDSA key fingerprint is MD5:f8:db:63:7c:11:be:19:c8:09:e5:e5:90:fc:f7:7f:a3.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.17.0.2' (ECDSA) to the list of known hosts.
root@172.17.0.2's password: 
-bash-4.2# ip a show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
170: eth0@if171: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
-bash-4.2# whoami
root
-bash-4.2# pwd
/root
-bash-4.2# ls -la
total 60
drwxrwxr-x. 2 1001 1003  4096 Aug 25 19:07 .
drwxr-xr-x. 1 root root  4096 Aug 25 18:52 ..
-rw-------. 1 root root    55 Aug 25 19:07 .bash_history
-rw-rw-r--. 1 1001 1003   503 Aug 25 17:57 Dockerfile
-rw-r--r--. 1 1001 1003   396 Aug 25 19:00 id_rsa.pub
-rw-rw-r--. 1 1001 1003 35575 Aug 25 17:58 log
-bash-4.2# logout
Connection to 172.17.0.2 closed.
```
