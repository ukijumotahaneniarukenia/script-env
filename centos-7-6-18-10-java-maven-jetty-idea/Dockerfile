FROM centos/systemd

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#各種コマンドいんすこ
RUN yum -y install epel-release
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which perl-Digest-SHA unzip evince

#javaコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz && \
tar xvf openjdk-11+28_linux-x64_bin.tar.gz

#mavenコマンドインストール
RUN cd /usr/local/src && \
curl -LO http://ftp.yz.yamagata-u.ac.jp/pub/network/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz && \
tar xvf apache-maven-3.6.3-bin.tar.gz

#jetty
RUN cd /usr/local/src && \
curl -LO https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.24.v20191120/jetty-distribution-9.4.24.v20191120.tar.gz && \
tar xvf jetty-distribution-9.4.24.v20191120.tar.gz

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#各種X関連コマンドインストール
RUN yum install -y xterm firefox PackageKit-gtk3-module
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0

#vimも最新
RUN yum install -y gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
cd /usr/local/src && git clone https://github.com/vim/vim.git && \
cd vim && \
./configure --enable-multibyte --with-features=huge --enable-cscope --enable-gui=gtk2 --disable-selinux --prefix=/usr/local --enable-xim --enable-fontset --enable-gpm --enable-rubyinterp --with-python-config-dir=/usr/lib/python2.7/config && \
make -j12 distclean && \
make -j12 && \
make -j12 install && \
ln -fsr /usr/local/bin/vim /usr/bin/vim && \
ln -fsr /usr/local/bin/vim /usr/bin/vi

#自身のvim環境をクローン
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv rc/.[^.]* ~ && \
#用が済んだらリム
rm -rf ~/tmp
#vim plugin manager
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#ideaインストール
COPY ideaIC-2019.2.4.tar.gz /usr/local/src/ideaIC-2019.2.4.tar.gz
RUN cd /usr/local/src && tar -xzf ideaIC-2019.2.4.tar.gz

USER kuraine

#自身のvim環境をクローン
RUN cd ~ && git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim
#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN cd ~ && git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv rc/.[^.]* ~ && \
#用が済んだらリム
rm -rf ~/tmp
#vim plugin manager
RUN mkdir -p ~/.vim/bundle && \
cd ~ && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle && rm -rf installer.sh

#alias設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'export JETTY_HOME=/usr/local/src/jetty-distribution-9.4.24.v20191120' >> ~/.bashrc && \
echo 'export MAVEN_HOME=/usr/local/src/apache-maven-3.6.3'>>~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$JETTY_HOME/bin:$MAVEN_HOME/bin:$PATH' >> ~/.bashrc && \
echo 'alias idea="/usr/local/src/idea-IC-192.7142.36/bin/idea.sh >~/launch_idea.log 2>&1 &"' >> ~/.bashrc

#jettyサービス外部公開ポート
EXPOSE 8080

WORKDIR /home/kuraine
