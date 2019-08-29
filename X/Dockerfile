FROM centos:latest

RUN yum install -y xterm xorg-x11-apps firefox dbus dbus-x11 xserver-xorg-legacy xinit xterm xorg ibus-kkc glibc-common

RUN dbus-uuidgen | tee /etc/machine-id

#日本語環境と時刻合わせ
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
