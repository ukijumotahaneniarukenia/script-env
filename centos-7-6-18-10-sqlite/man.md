# 参考文献
https://www.sqlite.org/src/doc/trunk/README.md </br>
https://www.sqlite.org/index.html</br>
https://sqlite.org/quickstart.html</br>

time docker build -t centos-7-6-18-10-sqlite . | tee log

docker run --privileged --shm-size=8gb --name centos-7-6-18-10-sqlite -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id centos-7-6-18-10-sqlite

docker exec -it centos-7-6-18-10-sqlite /bin/bash
