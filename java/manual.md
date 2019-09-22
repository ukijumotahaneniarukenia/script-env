# 参考文献

OpenJDKからいんすこ
https://openjdk.java.net/install/index.html

https://jdk.java.net/
https://jdk.java.net/13/

Java Path
http://devb.hatenablog.com/entry/20101203/1291391256

# Dockerfileよりイメージ作成

```
time docker build -t centos_java . | tee log
```


# dockerイメージ作成

```
time docker build -t centos_java . | tee log
```

# dockerコンテナ削除

```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerコンテナ作成

```
docker run --privileged --shm-size=8gb --name java -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 28787:8787  centos_java /sbin/init
```

# dockerコンテナ潜入

```
docker exec -it java /bin/bash
```

# jshell
https://qiita.com/HomMarkHunt/items/6579cc3587972909d85f
https://twitter.com/EclipseJavaIDE/status/1147044351278747648
```
[java@441a10f53644 /]$jshell
|  JShellへようこそ -- バージョン13
|  概要については、次を入力してください: /help intro

jshell> 

jshell> 

jshell> 

jshell> 

jshell> System.out.println("Hello World");
Hello World


```

# 絵文字をjavaで表示

https://qiita.com/carimatics/items/48ca30434f192549283c
https://github.com/vdurmont/emoji-java
Mavenからインストール
![](./1.png)
![](./2.png)
![](./3.png)

ディレクトリ構造
```
[java@441a10f53644 ~/IdeaProjects/untitled]$tree
.
|-- lib
|   |-- emoji-java-5.1.1-javadoc.jar
|   |-- emoji-java-5.1.1-sources.jar
|   |-- emoji-java-5.1.1.jar
|   |-- json-20170516-javadoc.jar
|   |-- json-20170516-sources.jar
|   `-- json-20170516.jar
|-- out
|   `-- production
|       `-- untitled
|           `-- emo.class
|-- src
|   `-- emo.java
`-- untitled.iml

5 directories, 9 files
```

javaファイル作成
```emo.java
import com.vdurmont.emoji.EmojiManager;

public class emo {
    public static void main(String[] args) {
        EmojiManager.getForAlias("name_badge");
        System.out.println(EmojiManager.getForAlias("name_badge").getUnicode());
    }
}
```
コンパイル
```
javac -d ../out/production/untitled -classpath /home/java/IdeaProjects/untitled/out/production/untitled:/home/java/IdeaProjects/untitled/lib/emoji-java-5.1.1.jar:/home/java/IdeaProjects/untitled/lib/json-20170516.jar emo.java
```
実行
```
/home/java/jdk-13/bin/java -javaagent:/home/java/idea-IC-192.6603.28/lib/idea_rt.jar=46144:/home/java/idea-IC-192.6603.28/bin -Dfile.encoding=UTF-8 -classpath /home/java/IdeaProjects/untitled/out/production/untitled:/home/java/IdeaProjects/untitled/lib/emoji-java-5.1.1.jar:/home/java/IdeaProjects/untitled/lib/json-20170516.jar emo
```
実行例
```
[java@441a10f53644 ~/IdeaProjects/untitled/src]$/home/java/jdk-13/bin/java -javaagent:/home/java/idea-IC-192.6603.28/lib/idea_rt.jar=46144:/home/java/idea-IC-192.6603.28/bin -Dfile.encoding=UTF-8 -classpath /home/java/IdeaProjects/untitled/out/production/untitled:/home/java/IdeaProjects/untitled/lib/emoji-java-5.1.1.jar:/home/java/IdeaProjects/untitled/lib/json-20170516.jar emo
📛
```
