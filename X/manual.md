## うまくいった
```
docker run -itd --name xxx -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix centos_x
docker exec -it xxx /bin/bash
```

## docker内でfirefox起動

```
[root@af6127a4ee17 /]# firefox
process 299: D-Bus library appears to be incorrectly set up; failed to read machine uuid: UUID file '/etc/machine-id' should contain a hex string of length 32, not length 0, with no other text
See the manual page for dbus-uuidgen to correct this issue.
  D-Bus not built with -rdynamic so unable to print a backtrace
Running without a11y support!
Gtk-Message: 11:50:11.435: Failed to load module "pk-gtk-module"
Gtk-Message: 11:50:11.435: Failed to load module "canberra-gtk-module"
Gtk-Message: 11:50:11.436: Failed to load module "pk-gtk-module"
Gtk-Message: 11:50:11.436: Failed to load module "canberra-gtk-module"
process 296: D-Bus library appears to be incorrectly set up; failed to read machine uuid: UUID file '/etc/machine-id' should contain a hex string of length 32, not length 0, with no other text
See the manual page for dbus-uuidgen to correct this issue.
  D-Bus not built with -rdynamic so unable to print a backtrace
Redirecting call to abort() to mozalloc_abort

Segmentation fault (core dumped)

```

## 参考文献
http://hisagi.hateblo.jp/entry/2017/10/21/234202
http://syuu1228.hatenablog.com/entry/20081210/1228895490

root権限コンテナ内で実行
```
dbus-uuidgen |sudo tee /etc/machine-id
```

```
[rstudio@centos ~/unko/script_scratch/X]$docker run -itd --name xxx -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix centos_x
84f815a3e4b0d8ab2331d698e89167d6fd687e4fd12d69c89fad08236b51f090
[rstudio@centos ~/unko/script_scratch/X]$docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
84f815a3e4b0        centos_x            "/bin/bash"         7 seconds ago       Up 6 seconds                            xxx
[rstudio@centos ~/unko/script_scratch/X]$docker exec -it xxx /bin/bash

```
