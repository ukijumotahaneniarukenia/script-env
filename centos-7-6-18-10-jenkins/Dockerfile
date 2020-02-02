FROM centos/systemd

#ユーザー作成
RUN groupadd -g 1001 jenkins && \
useradd -m -g jenkins -u 1001 jenkins && \
chsh -s /bin/bash jenkins && \
echo 'jenkins_pwd' | passwd --stdin jenkins && \
echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#各種コマンドいんすこ
RUN yum -y install epel-release && yum -y update
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which perl-Digest-SHA lbzip gcc-c++ libtool makeinfo file libffi-devel zlib-devel unzip autoconf gcc bison evince

#javaコマンドインストール
RUN cd /usr/local/src && \
curl -LO https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_linux-x64_bin.tar.gz && \
tar -zxvf openjdk-13_linux-x64_bin.tar.gz

#jenkinsいんすこ
RUN yum install -y initscripts wget && \
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo && \
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key && \
yum install -y jenkins

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#vimも最新
RUN yum install -y gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
cd ~ && git clone https://github.com/vim/vim.git && \
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

#X環境
#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0
RUN yum install -y xterm

#環境変数の設定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

USER jenkins

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

#環境変数の設定
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'export JAVA_HOME=/usr/local/src/jdk-13' >> ~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

#jenkinsサービス外部公開ポート
EXPOSE 8080

WORKDIR /home/jenkins
