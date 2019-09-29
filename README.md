# script_scratch

# dockerホスト環境
```
[aine@centos ~]$ cat /etc/redhat-release
CentOS Linux release 7.7.1908 (Core)
```

# docker install
[インストール手順公式HP](https://docs.docker.com/install/linux/docker-ce/centos/)
```
[aine@centos ~]$ su root
パスワード:
[root@centos aine]# yum remove docker \
>                   docker-client \
>                   docker-client-latest \
>                   docker-common \
>                   docker-latest \
>                   docker-latest-logrotate \
>                   docker-logrotate \
>                   docker-engine
読み込んだプラグイン:fastestmirror, langpacks
引数に一致しません: docker
引数に一致しません: docker-client
引数に一致しません: docker-client-latest
引数に一致しません: docker-common
引数に一致しません: docker-latest
引数に一致しません: docker-latest-logrotate
引数に一致しません: docker-logrotate
引数に一致しません: docker-engine
削除対象とマークされたパッケージはありません。
[root@centos aine]# yum install -y yum-utils \
>   device-mapper-persistent-data \
>   lvm2
読み込んだプラグイン:fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: ftp.nara.wide.ad.jp
 * extras: ftp.nara.wide.ad.jp
 * updates: ftp.nara.wide.ad.jp
パッケージ yum-utils-1.1.31-52.el7.noarch はインストール済みか最新バージョンです
パッケージ device-mapper-persistent-data-0.8.5-1.el7.x86_64 はインストール済みか最新バージョンです
パッケージ 7:lvm2-2.02.185-2.el7.x86_64 はインストール済みか最新バージョンです
何もしません
[root@centos aine]# yum-config-manager \
>     --add-repo \
>     https://download.docker.com/linux/centos/docker-ce.repo
読み込んだプラグイン:fastestmirror, langpacks
adding repo from: https://download.docker.com/linux/centos/docker-ce.repo
grabbing file https://download.docker.com/linux/centos/docker-ce.repo to /etc/yum.repos.d/docker-ce.repo
repo saved to /etc/yum.repos.d/docker-ce.repo
[root@centos aine]# yum install -y docker-ce docker-ce-cli containerd.io
[root@centos aine]# yum install -y docker-ce docker-ce-cli containerd.io
読み込んだプラグイン:fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: ftp.nara.wide.ad.jp
 * extras: ftp.nara.wide.ad.jp
 * updates: ftp.nara.wide.ad.jp
依存性の解決をしています
--> トランザクションの確認を実行しています。
---> パッケージ containerd.io.x86_64 0:1.2.6-3.3.el7 を インストール
--> 依存性の処理をしています: container-selinux >= 2:2.74 のパッケージ: containerd.io-1.2.6-3.3.el7.x86_64
---> パッケージ docker-ce.x86_64 3:19.03.2-3.el7 を インストール
---> パッケージ docker-ce-cli.x86_64 1:19.03.2-3.el7 を インストール
--> トランザクションの確認を実行しています。
---> パッケージ container-selinux.noarch 2:2.107-3.el7 を インストール
--> 依存性解決を終了しました。

依存性を解決しました

===================================================================================================================================================================================================================
 Package                                               アーキテクチャー                           バージョン                                            リポジトリー                                          容量
===================================================================================================================================================================================================================
インストール中:
 containerd.io                                         x86_64                                     1.2.6-3.3.el7                                         docker-ce-stable                                      26 M
 docker-ce                                             x86_64                                     3:19.03.2-3.el7                                       docker-ce-stable                                      24 M
 docker-ce-cli                                         x86_64                                     1:19.03.2-3.el7                                       docker-ce-stable                                      39 M
依存性関連でのインストールをします:
 container-selinux                                     noarch                                     2:2.107-3.el7                                         extras                                                39 k

トランザクションの要約
===================================================================================================================================================================================================================
インストール  3 パッケージ (+1 個の依存関係のパッケージ)

総ダウンロード容量: 90 M
インストール容量: 368 M
Downloading packages:
(1/4): container-selinux-2.107-3.el7.noarch.rpm                                                                                                                                             |  39 kB  00:00:00     
warning: /var/cache/yum/x86_64/7/docker-ce-stable/packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm: Header V4 RSA/SHA512 Signature, key ID 621e9f35: NOKEY                        ] 3.4 MB/s |  44 MB  00:00:13 ETA 
containerd.io-1.2.6-3.3.el7.x86_64.rpm の公開鍵がインストールされていません
(2/4): containerd.io-1.2.6-3.3.el7.x86_64.rpm                                                                                                                                               |  26 MB  00:00:12     
(3/4): docker-ce-19.03.2-3.el7.x86_64.rpm                                                                                                                                                   |  24 MB  00:00:15     
(4/4): docker-ce-cli-19.03.2-3.el7.x86_64.rpm                                                                                                                                               |  39 MB  00:00:10     
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
合計                                                                                                                                                                               3.9 MB/s |  90 MB  00:00:22     
https://download.docker.com/linux/centos/gpg から鍵を取得中です。
Importing GPG key 0x621E9F35:
 Userid     : "Docker Release (CE rpm) <docker@docker.com>"
 Fingerprint: 060a 61c5 1b55 8a7f 742b 77aa c52f eb6b 621e 9f35
 From       : https://download.docker.com/linux/centos/gpg
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  インストール中          : 2:container-selinux-2.107-3.el7.noarch                                                                                                                                             1/4 
  インストール中          : containerd.io-1.2.6-3.3.el7.x86_64                                                                                                                                                 2/4 
  インストール中          : 1:docker-ce-cli-19.03.2-3.el7.x86_64                                                                                                                                               3/4 
  インストール中          : 3:docker-ce-19.03.2-3.el7.x86_64                                                                                                                                                   4/4 
  検証中                  : 3:docker-ce-19.03.2-3.el7.x86_64                                                                                                                                                   1/4 
  検証中                  : 2:container-selinux-2.107-3.el7.noarch                                                                                                                                             2/4 
  検証中                  : containerd.io-1.2.6-3.3.el7.x86_64                                                                                                                                                 3/4 
  検証中                  : 1:docker-ce-cli-19.03.2-3.el7.x86_64                                                                                                                                               4/4 

インストール:
  containerd.io.x86_64 0:1.2.6-3.3.el7                                   docker-ce.x86_64 3:19.03.2-3.el7                                   docker-ce-cli.x86_64 1:19.03.2-3.el7                                  

依存性関連をインストールしました:
  container-selinux.noarch 2:2.107-3.el7                                                                                                                                                                           

完了しました!
[root@centos aine]# docker --version
Docker version 19.03.2, build 6a30dfc
[root@centos aine]# systemctl start docker
[root@centos aine]# systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/usr/lib/systemd/system/docker.service; disabled; vendor preset: disabled)
   Active: active (running) since 日 2019-09-29 21:00:48 JST; 4s ago
     Docs: https://docs.docker.com
 Main PID: 5191 (dockerd)
    Tasks: 20
   Memory: 46.5M
   CGroup: /system.slice/docker.service
           └─5191 /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

 9月 29 21:00:47 centos dockerd[5191]: time="2019-09-29T21:00:47.357620849+09:00" level=info msg="ClientConn switching balancer to \"pick_first\"" module=grpc
 9月 29 21:00:47 centos dockerd[5191]: time="2019-09-29T21:00:47.357646903+09:00" level=info msg="pickfirstBalancer: HandleSubConnStateChange: 0xc000869330, CONNECTING" module=grpc
 9月 29 21:00:47 centos dockerd[5191]: time="2019-09-29T21:00:47.357793073+09:00" level=info msg="pickfirstBalancer: HandleSubConnStateChange: 0xc000869330, READY" module=grpc
 9月 29 21:00:47 centos dockerd[5191]: time="2019-09-29T21:00:47.404995715+09:00" level=info msg="Loading containers: start."
 9月 29 21:00:47 centos dockerd[5191]: time="2019-09-29T21:00:47.997788662+09:00" level=info msg="Default bridge (docker0) is assigned with an IP address 172.17.0.0/16. Daemon option --bip can...red IP address"
 9月 29 21:00:48 centos dockerd[5191]: time="2019-09-29T21:00:48.271931938+09:00" level=info msg="Loading containers: done."
 9月 29 21:00:48 centos dockerd[5191]: time="2019-09-29T21:00:48.308019934+09:00" level=info msg="Docker daemon" commit=6a30dfc graphdriver(s)=overlay2 version=19.03.2
 9月 29 21:00:48 centos dockerd[5191]: time="2019-09-29T21:00:48.308124811+09:00" level=info msg="Daemon has completed initialization"
 9月 29 21:00:48 centos dockerd[5191]: time="2019-09-29T21:00:48.346210328+09:00" level=info msg="API listen on /var/run/docker.sock"
 9月 29 21:00:48 centos systemd[1]: Started Docker Application Container Engine.
Hint: Some lines were ellipsized, use -l to show in full.
[root@centos aine]# docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
1b930d010525: Pull complete 
Digest: sha256:b8ba256769a0ac28dd126d584e0a2011cd2877f3f76e093a7ae560f2a5301c00
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

[root@centos aine]# usermod -aG docker aine
[root@centos aine]# visudo
## Same thing without a password
# %wheel        ALL=(ALL)       NOPASSWD: ALL
  %docker       ALL=(ALL)       NOPASSWD: ALL
[aine@centos ~]$ LANG=C xdg-user-dirs-gtk-update
Gtk-Message: 21:06:55.787: GtkDialog mapped without a transient parent. This is discouraged.
Moving DESKTOP directory from デスクトップ to Desktop
Moving DOWNLOAD directory from ダウンロード to Downloads
Moving TEMPLATES directory from テンプレート to Templates
Moving PUBLICSHARE directory from 公開 to Public
Moving DOCUMENTS directory from ドキュメント to Documents
Moving MUSIC directory from 音楽 to Music
Moving PICTURES directory from 画像 to Pictures
Moving VIDEOS directory from ビデオ to Videos
[aine@centos ~]$ sudo reboot
[root@centos aine]# cat <<EOF >/etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF
[root@centos aine]# yum install -y google-chrome-stable

```
