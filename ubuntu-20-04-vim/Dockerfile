FROM ubuntu:20.04

RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list && \
apt update && \
apt upgrade -y

ENV DISPLAY=:0.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y systemd

RUN apt install -y init

RUN apt install -y xinit

CMD ["/sbin/init"]
