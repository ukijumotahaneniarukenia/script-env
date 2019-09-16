# 自動ビルド対象のレポジトリ作成
![](./1.png)
![](./2.png)
![](./3.png)
dockerコンテナ内の作業ディレクトリにおいて以下のコマンドを実行
```
[rstudio@79ace1891861 ~]$ echo "# sandbox2" >> README.md
[rstudio@79ace1891861 ~]$ git init
Initialized empty Git repository in /home/rstudio/.git/
[rstudio@79ace1891861 ~]$ git add README.md
[rstudio@79ace1891861 ~]$ git commit -m "first commit"

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident name (for <rstudio@79ace1891861.(none)>) not allowed
[rstudio@79ace1891861 ~]$ git config --global user.email "unko@gmail.com"
[rstudio@79ace1891861 ~]$ git config --global user.name "ukijumotahaneniarukenia"
[rstudio@79ace1891861 ~]$ git commit -m "first commit"
[master (root-commit) 7d7662f] first commit
 1 file changed, 1 insertion(+)
 create mode 100644 README.md
[rstudio@79ace1891861 ~]$ git remote add origin https://github.com/ukijumotahaneniarukenia/sandbox2.git
[rstudio@79ace1891861 ~]$ git push -u origin master
Username for 'https://github.com': ukijumotahaneniarukenia
Password for 'https://ukijumotahaneniarukenia@github.com': 
Counting objects: 3, done.
Writing objects: 100% (3/3), 233 bytes | 0 bytes/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://github.com/ukijumotahaneniarukenia/sandbox2.git
 * [new branch]      master -> master
Branch master set up to track remote branch master from origin.
```
ブラウザをリフレッシュ後
![](./4.png)

# 自動ビルド対象のレポジトリをクローン
dockerコンテナ内の作業ディレクトリにおいて以下のコマンドを実行
```
[rstudio@3f2d79d4d6af ~]$ ls
[rstudio@3f2d79d4d6af ~]$ git clone https://github.com/ukijumotahaneniarukenia/sandbox2.git
Cloning into 'sandbox2'...
remote: Enumerating objects: 3, done.
remote: Counting objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 3 (delta 0), pack-reused 0
Unpacking objects: 100% (3/3), done.
[rstudio@3f2d79d4d6af ~]$ ls
sandbox2
[rstudio@3f2d79d4d6af ~]$ cd sandbox2/
[rstudio@3f2d79d4d6af sandbox2]$ ls
README.md
```

# 作業用ディレクトリでの成果物を自動ビルド対象のレポジトリにコミット
```

```

# dockerコンテナ潜入後、初期パスワードを確認
```
[root@e0f1e2a88da2 /]# cat /var/lib/jenkins/secrets/initialAdminPassword
3d6bf8c990be4c2492c4d2b1806431c0
```

# ブラウザよりjenkins起動確認
```
http://192.168.1.109:18080
```

# jenkins初期設定
![](./6.png)
![](./7.png)
![](./8.png)
![](./9.png)
![](./10.png)
![](./11.png)
![](./12.png)

# jenkinsにNodejsファイル実行プラグインをインストール
テスト対象の言語に応じてプラグインをインストールする
```

```

# jenkinsにDSLファイル実行プラグインをインストール
DSLファイルは自動実行するためのjenkinsに対する指示書。groovyの言語仕様で記載。
```

```

# jenkinsにテストジョブを登録
```

```

# jenkinsからテストジョブを実行
```

```

# コンソールログより実行結果確認
```

```

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb --name jenkins -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 13000:3000 -p 280:80 -p 18080:8080 centos_jenkins /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it jenkins /bin/bash
```

# 参考文献
https://casualdevelopers.com/tech-tips/how-to-install-and-use-jenkins-on-docker-for-nodejs/
https://jenkins.io/download/
https://pkg.jenkins.io/redhat/
https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions
https://unix.stackexchange.com/questions/9314/no-such-file-or-directory-etc-init-d-functions
http://arasio.hatenablog.com/entry/2016/10/07/005055

# nodeアプリ参考文献
https://casualdevelopers.com/tech-tips/how-to-install-and-use-jenkins-on-docker-for-nodejs/#Jenkins-3
https://casualdevelopers.com/tech-tips/how-to-install-and-use-jenkins-on-docker-for-nodejs/
http://tech-blog.rakus.co.jp/entry/2018/03/05/094238#%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89
https://github.com/ryo-ohnishi/node_express_nginx
https://qiita.com/ryo-ohnishi/items/b54e649b14b51694ef77
https://qiita.com/ryo-ohnishi/items/3653f7583c8591eef333

