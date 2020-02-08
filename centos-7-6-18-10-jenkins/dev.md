# 参考文献

- https://jenkins.io/doc/pipeline/tour/getting-started/

- https://jenkins.io/doc/tutorials/

# jenkinsプロセス起動

- warファイルのパスを確認

```
$find / -name "jenkins.war" 2>/dev/null
/usr/lib/jenkins/jenkins.war
```

```
$java -jar /usr/lib/jenkins/jenkins.war 1>~/launch-jenkins.log 2>&1 &
[1] 831
```

- プロセス確認

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
jenkins      1  0.0  0.0  42696  1284 pts/0    Ss+  19:06   0:00 /usr/sbin/init
jenkins    831 54.4 10.1 15279740 3323272 ?    Sl   20:07   0:28 java -jar /usr/lib/jenkins/jenkins.war
jenkins    938  0.0  0.0  14380  2020 pts/2    Ss   20:07   0:00 /bin/bash
jenkins    955  0.0  0.0  54304  1852 pts/2    R+   20:08   0:00 ps aux
```

- ログ確認

```
$tail -f ~/launch-jenkins.log
```

- イニシャルパスワード確認

```
$grep -B2 initialAdminPassword ~/launch-jenkins.log | head -n1
```

- 待受ポート確認

```
$lsof -P -i:8080
COMMAND PID    USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
java    831 jenkins  142u  IPv4 12406050      0t0  TCP *:8080 (LISTEN)
```

- ブラウザアクセス

  - http://192.168.1.109:8080

|key|value|
|:-:|:-:|
|ユーザー名|jenkins|
|パスワード|jenkins_pwd|
|パスワードの確認|jenkins_pwd|
|フルネーム|ukijumotahaneniarukenia|
|メールアドレス|mrchildrenkh1008@gmail.com|


# 自動ビルド対象のレポジトリ作成

- dockerコンテナ内の作業ディレクトリにおいてンドを実行

  - githubのマイページより実施

```
$git config --global user.email "mrchildrenkh1008@gmail.com"
$git config --global user.name "ukijumotahaneniarukenia"
$echo "# sandbox2" >> README.md
$git init
$git add README.md
$git commit -m "first commit"
$git remote add origin https://github.com/ukijumotahaneniarukenia/sandbox2.git
$git push -u origin master
```

# 自動ビルド対象のレポジトリをクローン

# jenkinsにプラグインをインストール
- テスト対象の言語に応じてプラグインをインストールする

# プラグインの有効化

# jenkinsにDSLファイル実行プラグインをインストール
DSLファイルは自動実行するためのjenkinsに対する指示書。groovyの言語仕様で記載。

# jenkinsにテストジョブを登録

# jenkinsユーザーがDSLファイルを実行できるように許可する
In-Process Script Approvalは5分ほど待つと表示されると思ったが、
一度実行してから表示されるぽい

# jenkinsからテストジョブを実行
認証許可せず、実行するとテストは失敗する

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

# 実行許可付与後、ビルド実行

# DSLファイルの記載内容がjenkinsに反映されているか確認

# レポジトリにコミットをトリガにしてビルド実行
