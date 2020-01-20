# 参考文献

https://www.slideshare.net/RansuiIso/pyqtgui</br>
https://qiita.com/Dreamwalker/items/60b9fbc931381a849525</br>
https://qiita.com/Dreamwalker/items/de2e200c09f6807932e8

# dockerイメージ作成

```
time docker build -t ubuntu_pyqt . | tee log
```

# dockerコンテナ削除

```
docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
```

# dockerイメージ削除

```
docker images | awk '$1=="<none>"{print $3}' | xargs -I@ docker rmi @
```

# dockerコンテナ起動

```
docker run --privileged --shm-size=8gb --name ubuntu-pyqt -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 3306:3306 ubuntu_pyqt
```

# dockerコンテナ潜入

```
docker exec -it ubuntu-pyqt /bin/bash
```

# pyqtライブラリいんすこ

pythonスクリプトからqtライブラリを使用できるように設定

以下を参考
https://askubuntu.com/questions/1009840/how-to-install-pyqt5 </br>
https://tutorialmore.com/questions-972030.htm </br>

rootユーザーで以下のコマンドを実行

```
$apt-get install -y python3-qtpy pyqt5-dev pyqt5-dev-tools python3-pyqt5 libqt5widgets5 libqt5gui5 libqt5dbus5 libqt5network5 libqt5core5a
$pip3 install SIP
$pip3 install PyQt5
```

以下のコマンドでpyqt5関連のライブラリパッケージの名前を検討つけられる

```
$apt-cache search pyqt5 | nl
```

# qtデザイナーを起動

以下を参考

https://pythonbasics.org/qt-designer-python/

普通に起動すると動かないが、以下のコマンドを実行したあとだと動いた

```
$strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
```

単体起動するときは以下のコマンドを実行
これはqtでプレイした結果をホームディレクトリの直下のワークスペースディレクトリに保存する
```
( mkdir -p $HOME/qt-wrksp && export XDG_RUNTIME_DIR=$HOME/qt-wrksp && cd /usr/lib/x86_64-linux-gnu/qt5/bin && ./designer 1>~/launch_qt_designer.log 2>&1 </dev/null & )
```

プロセス確認

./designerコマンドが起動されている

```
$ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0   4076  1984 pts/0    Ss+  Jan20   0:00 /bin/bash
root     11122  0.0  0.0   4208  2332 pts/1    Ss   Jan20   0:00 /bin/bash
root     11150  0.0  0.0   6964   800 pts/1    S    Jan20   0:00 dbus-launch --autolaunch bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
root     11151  0.0  0.0   7064  1312 ?        Ss   Jan20   0:00 /usr/bin/dbus-daemon --syslog-only --fork --print-pid 5 --print-address 7 --session
root     11180  0.0  0.0   5160  2232 pts/1    S    00:07   0:00 su kuraine
kuraine  11181  0.0  0.0   4208  2216 pts/1    S    00:07   0:00 bash
kuraine  11189  0.0  0.0   4208   756 pts/1    S    00:07   0:00 bash
kuraine  11190  1.9  0.2 1592224 81100 pts/1   Sl   00:07   0:00 ./designer
kuraine  11197  0.0  0.0   6964   796 pts/1    S    00:07   0:00 dbus-launch --autolaunch bc74deaa9e044c079ed6fc963d084157 --binary-syntax --close-stderr
kuraine  11198  0.0  0.0   7064  1304 ?        Ss   00:07   0:00 /usr/bin/dbus-daemon --syslog-only --fork --print-pid 5 --print-address 7 --session
kuraine  11201  0.0  0.0   5844  1468 pts/1    R+   00:07   0:00 ps aux
```

ログ確認
```
$tail ~/launch_qt_designer.log
```
