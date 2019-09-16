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
[rstudio@79ace1891861 ~]$ git config --global user.email "mrchildrenkh1008@gmail.com"
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
[rstudio@0118397ab4ba sandbox2]$ mkdir {src,test,usage}
[rstudio@0118397ab4ba sandbox2]$ tree
.
├── README.md
├── src
├── test
└── usage

3 directories, 1 file
[rstudio@0118397ab4ba sandbox2]$ tree
.
├── README.md
├── src
│   └── utils.js
├── test
│   └── utils.js
└── usage
    └── index.js

3 directories, 4 files
[rstudio@0118397ab4ba sandbox2]$ cat src/utils.js 
const math = {
  add: (x, y) => x + y,
  subtract: (x, y) => x - y
};

module.exports = { math };
[rstudio@0118397ab4ba sandbox2]$ cat test/utils.js 
const { math } = require('../src/utils')

describe('utils test', () => {
  describe('math test', () => {
    test('should be 3 when adding 1 and 2', () => {
      expect(math.add(1, 2)).toBe(3);
    });

    test('should be -1 when subtracting 2 from 1', () => {
      expect(math.subtract(1, 2)).toBe(-1);
    });
  });
});
[rstudio@0118397ab4ba sandbox2]$ cat usage/index.js 
const { math } = require('../src/utils');

console.log(`Next year is ${math.add(2018, 1)}.`);
console.log(`${math.subtract(2020, 2018)} years until Tokyo Olympic.`);
[rstudio@0118397ab4ba sandbox2]$ cat nodejs.groovy
job('NodeJS_TestJob_01') {
    scm {
        git('https://github.com/ukijumotahaneniarukenia/sandbox2.git') {  node ->
            node / gitConfigName('ukijumotahaneniarukenia')
            node / gitConfigEmail('mrchildrenkh1008@gmail.com')
        }
    }
    triggers {
        scm('H/5 * * * *')
    }
    wrappers {
        nodejs('nodejs_test')
    }
    steps {
        shell("npm install")
        shell("npm test")
    }
}
[rstudio@0118397ab4ba sandbox2]$ tree
.
├── nodejs.groovy
├── README.md
├── src
│   └── utils.js
├── test
│   └── utils.js
└── usage
    └── index.js

3 directories, 5 files
[rstudio@0118397ab4ba sandbox2]$ ll
total 20
-rw-rw-r--. 1 rstudio rstudio  433 Sep 16 14:07 nodejs.groovy
-rw-rw-r--. 1 rstudio rstudio   11 Sep 16 13:54 README.md
drwxrwxr-x. 2 rstudio rstudio 4096 Sep 16 13:58 src
drwxrwxr-x. 2 rstudio rstudio 4096 Sep 16 13:58 test
drwxrwxr-x. 2 rstudio rstudio 4096 Sep 16 13:59 usage
[rstudio@0118397ab4ba sandbox2]$ git add .
[rstudio@0118397ab4ba sandbox2]$ git commit -m "成果物"

*** Please tell me who you are.

Run

  git config --global user.email "you@example.com"
  git config --global user.name "Your Name"

to set your account's default identity.
Omit --global to set the identity only in this repository.

fatal: empty ident name (for <rstudio@0118397ab4ba.(none)>) not allowed
[rstudio@0118397ab4ba sandbox2]$ git config --global user.email "mrchildrenkh1008@gmail.com"
[rstudio@0118397ab4ba sandbox2]$ git config --global user.name "ukijumotahaneniarukenia"
[rstudio@0118397ab4ba sandbox2]$ git commit -m "成果物"
[master 74d1ea0] 成果物
 4 files changed, 41 insertions(+)
 create mode 100644 nodejs.groovy
 create mode 100644 src/utils.js
 create mode 100644 test/utils.js
 create mode 100644 usage/index.js
[rstudio@0118397ab4ba sandbox2]$ git push -u origin master
Username for 'https://github.com': ukijumotahaneniarukenia
Password for 'https://ukijumotahaneniarukenia@github.com': 
Counting objects: 10, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (6/6), done.
Writing objects: 100% (9/9), 1.14 KiB | 0 bytes/s, done.
Total 9 (delta 0), reused 0 (delta 0)
To https://github.com/ukijumotahaneniarukenia/sandbox2.git
   7d7662f..74d1ea0  master -> master
Branch master set up to track remote branch master from origin.

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
![](./13.png)
![](./14.png)
![](./15.png)
![](./16.png)
![](./17.png)
![](./18.png)

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

