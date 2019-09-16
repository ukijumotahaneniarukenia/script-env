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

# NodeJsプラグインを有効化する
![](./27.png)
![](./28.png)
![](./29.png)

# jenkinsにDSLファイル実行プラグインをインストール
DSLファイルは自動実行するためのjenkinsに対する指示書。groovyの言語仕様で記載。
![](./19.png)
![](./20.png)
![](./21.png)

# jenkinsにテストジョブを登録
![](./22.png)
![](./23.png)
![](./24.png)
![](./25.png)
![](./26.png)

# jenkinsユーザーがDSLファイルを実行できるように許可する
In-Process Script Approvalは5分ほど待つと表示されると思ったが、
一度実行してから表示されるぽい

# jenkinsからテストジョブを実行
認証許可せず、実行するとテストは失敗する
![](./30.png)
![](./31.png)
![](./32.png)
![](./33.png)


# サーバ上のファイルでの実行ログ
workspace配下にクローンしてきて実行しているぽい
```
[root@0118397ab4ba jenkins]# pwd
/var/lib/jenkins
[root@0118397ab4ba jenkins]# ll
total 172
-rw-r--r--.  1 jenkins jenkins  1644 Sep 16 14:41 config.xml
-rw-r--r--.  1 jenkins jenkins   156 Sep 16 14:22 hudson.model.UpdateCenter.xml
-rw-r--r--.  1 jenkins jenkins   370 Sep 16 14:40 hudson.plugins.git.GitTool.xml
-rw-r--r--.  1 jenkins jenkins   173 Sep 16 14:40 hudson.plugins.gradle.Gradle.xml
-rw-r--r--.  1 jenkins jenkins   146 Sep 16 14:40 hudson.tasks.Ant.xml
-rw-r--r--.  1 jenkins jenkins   132 Sep 16 14:40 hudson.tasks.Maven.xml
-rw-------.  1 jenkins jenkins  1712 Sep 16 13:44 identity.key.enc
-rw-r--r--.  1 jenkins jenkins     7 Sep 16 13:48 jenkins.install.InstallUtil.lastExecVersion
-rw-r--r--.  1 jenkins jenkins     7 Sep 16 13:48 jenkins.install.UpgradeWizard.state
-rw-r--r--.  1 jenkins jenkins   184 Sep 16 13:48 jenkins.model.JenkinsLocationConfiguration.xml
-rw-r--r--.  1 jenkins jenkins   247 Sep 16 14:40 jenkins.mvn.GlobalMavenConfig.xml
-rw-r--r--.  1 jenkins jenkins   867 Sep 16 14:40 jenkins.plugins.nodejs.tools.NodeJSInstallation.xml
-rw-r--r--.  1 jenkins jenkins   171 Sep 16 13:44 jenkins.telemetry.Correlator.xml
drwxr-xr-x.  3 jenkins jenkins  4096 Sep 16 14:29 jobs
drwxr-xr-x.  3 jenkins jenkins  4096 Sep 16 13:44 logs
-rw-r--r--.  1 jenkins jenkins   907 Sep 16 14:22 nodeMonitors.xml
drwxr-xr-x.  2 jenkins jenkins  4096 Sep 16 13:44 nodes
-rw-r--r--.  1 jenkins jenkins   299 Sep 16 14:40 org.jenkinsci.plugins.docker.commons.tools.DockerTool.xml
-rw-r--r--.  1 jenkins jenkins   255 Sep 16 14:40 org.jenkinsci.plugins.gitclient.JGitApacheTool.xml
-rw-r--r--.  1 jenkins jenkins   243 Sep 16 14:40 org.jenkinsci.plugins.gitclient.JGitTool.xml
drwxr-xr-x. 78 jenkins jenkins 12288 Sep 16 14:22 plugins
-rw-r--r--.  1 jenkins jenkins   129 Sep 16 14:45 queue.xml
-rw-r--r--.  1 jenkins jenkins   129 Sep 16 14:41 queue.xml.bak
-rw-r--r--.  1 jenkins jenkins   977 Sep 16 14:44 scriptApproval.xml
-rw-r--r--.  1 jenkins jenkins    64 Sep 16 13:44 secret.key
-rw-r--r--.  1 jenkins jenkins     0 Sep 16 13:44 secret.key.not-so-secret
drwx------.  4 jenkins jenkins  4096 Sep 16 14:45 secrets
drwxr-xr-x.  2 jenkins jenkins  4096 Sep 16 14:17 updates
drwxr-xr-x.  2 jenkins jenkins  4096 Sep 16 13:44 userContent
drwxr-xr-x.  3 jenkins jenkins  4096 Sep 16 13:48 users
drwxr-xr-x.  2 jenkins jenkins  4096 Sep 16 13:46 workflow-libs
drwxr-xr-x.  3 jenkins jenkins  4096 Sep 16 14:44 workspace
[root@0118397ab4ba jenkins]# cd workspace
[root@0118397ab4ba workspace]# ll
total 4
drwxr-xr-x. 6 jenkins jenkins 4096 Sep 16 14:44 NodeJs
[root@0118397ab4ba workspace]# cd NodeJs
[root@0118397ab4ba NodeJs]# ll
total 20
-rw-r--r--. 1 jenkins jenkins  433 Sep 16 14:44 nodejs.groovy
-rw-r--r--. 1 jenkins jenkins   11 Sep 16 14:44 README.md
drwxr-xr-x. 2 jenkins jenkins 4096 Sep 16 14:44 src
drwxr-xr-x. 2 jenkins jenkins 4096 Sep 16 14:44 test
drwxr-xr-x. 2 jenkins jenkins 4096 Sep 16 14:44 usage
```

# DSLスクリプト実行許可付与
![](./34.png)
![](./35.png)

# 実行許可付与後、ビルド実行
![](./36.png)
![](./37.png)
![](./38.png)
![](./39.png)

# レポジトリにコミットをトリガにしてビルド実行



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

