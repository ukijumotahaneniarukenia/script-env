FROM ubuntu:19.10

#レポジトリを日本サーバーの一つに変更
RUN sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list

RUN apt-get update && apt-get upgrade -y

#各種コマンドないしライブラリインストール
RUN apt-get install -y vim gcc make lsb-release wget gnupg sudo && \
apt-get install -y libffi-dev curl build-essential libssl-dev zlib1g-dev libreadline6-dev && \
apt-get install -y libncurses5-dev libgdbm-dev libnss3-dev libreadline-dev wget libgl1-mesa-dev

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
echo 'kuraine:kuraine_pwd' | chpasswd && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
chsh -s /bin/bash kuraine

RUN echo 'root:root_pwd' | chpasswd

#javaコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz && \
tar -zxvf openjdk-13_linux-x64_bin.tar.gz

#mavenコマンドインストール
RUN cd /usr/local/src && \
curl -LO http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
tar xvf apache-maven-3.6.3-bin.tar.gz

#gradleコマンドインストール
RUN apt-get install -y unzip
COPY gradle-6.1-all.zip /usr/local/src/gradle-6.1-all.zip
RUN cd /usr/local/src && unzip gradle-6.1-all.zip

#環境変数の設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'export MAVEN_HOME=/usr/local/src/apache-maven-3.6.3'>>~/.bashrc && \
echo 'export GRADLE_HOME=/usr/local/src/gradle-6.1'>>~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin:$PATH' >> ~/.bashrc

#X環境インストール
RUN apt-get install -y xterm
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

COPY mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb /usr/local/src/mysql-workbench-community_8.0.19-1ubuntu19.10_amd64.deb

USER kuraine

#環境変数の設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'export MAVEN_HOME=/usr/local/src/apache-maven-3.6.3'>>~/.bashrc && \
echo 'export GRADLE_HOME=/usr/local/src/gradle-6.1'>>~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$MAVEN_HOME/bin:$GRADLE_HOME/bin:$PATH' >> ~/.bashrc

WORKDIR /home/kuraine
