FROM ubuntu:19.10

RUN apt-get update && apt-get upgrade -y

#ユーザー作成
RUN groupadd -g 1001 mysql && \
useradd -m -g mysql -u 1001 mysql && \
echo 'mysql:mysql_pwd' | chpasswd && \
echo 'mysql ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash mysql

RUN echo 'root:root_pwd' | chpasswd
