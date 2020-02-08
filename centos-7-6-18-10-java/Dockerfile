FROM centos/systemd

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#mavenコマンドインストール
RUN cd /usr/local/src && \
curl -LO http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
tar xvf apache-maven-3.6.3-bin.tar.gz

#jetty
RUN cd /usr/local/src && \
curl -LO https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.24.v20191120/jetty-distribution-9.4.24.v20191120.tar.gz && \
tar xvf jetty-distribution-9.4.24.v20191120.tar.gz

#apache-tomcat
RUN cd /usr/local/src && \
curl -LO http://ftp.riken.jp/net/apache/tomcat/tomcat-9/v9.0.30/bin/apache-tomcat-9.0.30.tar.gz && \
tar xvf apache-tomcat-9.0.30.tar.gz && \
chmod -R 755 apache-tomcat-9.0.30

#ideaインストール
COPY ideaIC-2019.2.4.tar.gz /usr/local/src/ideaIC-2019.2.4.tar.gz
RUN cd /usr/local/src && tar -xzf ideaIC-2019.2.4.tar.gz

#eclipse-stsインストール
RUN cd /usr/local/src && curl -LO https://download.springsource.com/release/STS/3.9.11.RELEASE/dist/e4.14/spring-tool-suite-3.9.11.RELEASE-e4.14.0-linux-gtk-x86_64.tar.gz && \
tar xvf spring-tool-suite-3.9.11.RELEASE-e4.14.0-linux-gtk-x86_64.tar.gz && \
cd sts-bundle/sts-3.9.11.RELEASE

USER kuraine

#alias設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'export JETTY_HOME=/usr/local/src/jetty-distribution-9.4.24.v20191120' >> ~/.bashrc && \
echo 'export CATALINA_HOME=/usr/local/src/apache-tomcat-9.0.30' >> ~/.bashrc && \
echo 'export STS_HOME=/usr/local/src/sts-bundle/sts-3.9.11.RELEASE'>>~/.bashrc && \
echo 'export MAVEN_HOME=/usr/local/src/apache-maven-3.6.3'>>~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$CATALINA_HOME/bin:$JETTY_HOME/bin:$STS_HOME:$MAVEN_HOME/bin:$PATH' >> ~/.bashrc && \
echo 'alias idea="/usr/local/src/idea-IC-192.7142.36/bin/idea.sh >~/launch_idea.log 2>&1 &"' >> ~/.bashrc && \
echo 'alias sts="$STS_HOME/STS 1>~/launch_sts.log 2>&1 &"'>>~/.bashrc

#jettyサービス外部公開ポート
EXPOSE 8080

WORKDIR /home/kuraine

CMD ["/usr/sbin/init"]
