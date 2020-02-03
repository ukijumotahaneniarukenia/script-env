FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y

#ユーザー作成
RUN groupadd -g 1001 software && \
useradd -m -g software -u 1001 software && \
echo 'software:software_pwd' | chpasswd && \
echo 'software ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash software && \
chmod 777 /home/software

RUN echo 'root:root_pwd' | chpasswd

COPY v11.5_linuxx64_dec.tar.gz /home/software/v11.5_linuxx64_dec.tar.gz

RUN chmod 777 /home/software && \
cd /home/software && \
gunzip *.gz && \
tar -xvf v11.5_linuxx64_dec.tar && \
rm v11.5_linuxx64_dec.tar && \
chmod 777 server_dec && \
mv server_dec ibm-db2 && \
cd ibm-db2 && \
apt -y install libaio1 zlib1g-dev libnuma-dev libpam0g-dev file gcc make && \
dpkg --add-architecture i386 && \
apt update && \
apt install -y binutils libaio1 libstdc++6:i386 libpam0g:i386 libxext-dev

#X環境インストール
RUN apt-get install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

WORKDIR /home/software/ibm-db2
