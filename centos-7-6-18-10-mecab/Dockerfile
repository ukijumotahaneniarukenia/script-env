FROM centos/systemd

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドいんすこ
RUN yum -y install epel-release && yum update -y
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man moreutils lbzip2 which perl-Digest-SHA evince gcc-c++

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

#javaコマンドいんすこ
RUN cd /usr/local/src && curl -LO https://download.java.net/java/GA/jdk13.0.1/cec27d702aa74d5a8630c65ae61e4305/9/GPL/openjdk-13.0.1_linux-x64_bin.tar.gz && \
tar xvf openjdk-13*_bin.tar.gz

#alias設定
RUN echo 'export JAVA_HOME=/usr/local/src/jdk-13.0.1' >> ~/.bashrc && \
echo 'export LD_LIBRARY_PATH=/usr/local/lib' >> ~/.bashrc && \
echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bashrc

#mecabコマンドインストール
COPY mecab-0.996.tar.gz /usr/local/src/mecab-0.996.tar.gz
RUN cd /usr/local/src && tar xvf mecab-0.996.tar.gz && \
cd mecab-0.996 && \
./configure && \
make -j12 && \
make -j12 install

COPY mecab-ipadic-2.7.0-20070801.tar.gz /usr/local/src/mecab-ipadic-2.7.0-20070801.tar.gz
RUN cd /usr/local/src && tar xvf mecab-ipadic-2.7.0-20070801.tar.gz && \
cd mecab-ipadic-2.7.0-20070801 && \
./configure --with-charset=utf8 && \
make -j12 && \
make -j12 install

COPY mecab-java-0.996.tar.gz /usr/local/src/mecab-java-0.996.tar.gz

RUN cd /usr/local/src && curl -LO https://mecab.googlecode.com/files/mecab-java-0.996.tar.gz

WORKDIR /usr/local/src
