FROM centos:7.6.1810

#ユーザー作成
RUN groupadd -g 1002 sqlite
RUN useradd -m -g sqlite -u 1002 sqlite
RUN chsh -s /bin/bash sqlite
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'sqlite_pwd' | passwd --stdin sqlite
RUN echo 'sqlite ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#epelレポ登録
RUN yum -y install epel-release

#各種コマンドインストール
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man
RUN yum install -y moreutils

#perl パッケージ管理cpanmないしcpanインストール
RUN yum install -y which perl-App-cpanminus wxGTK-devel perl-ExtUtils-Embed perl-File-HomeDir perl-Term-ReadLine-Gnu wxGTK3 cpan

#Tukubaiコマンドは便利
RUN cd ~ && git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make -j12 install

#awkコマンドは最新の奴 include使える
RUN cd ~ && curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make -j12 && \
make -j12 install

#bashも最新
RUN cd ~ && curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
tar -zxvf bash-5.0.tar.gz && \
cd bash-5.0 && \
./configure && \
make -j12 && \
make -j12 install

#vimも最新
RUN yum install -y sudo gcc git gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
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

#parallelコマンド install
RUN cd ~ && yum install -y bzip2 && curl -LO http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 && \
tar jxf parallel-latest.tar.bz2 && \
cd parallel-20191022 && \
./configure && \
make -j12 && \
make -j12 install

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#sqlite install
RUN cd /usr/local/src && curl -LO https://www.sqlite.org/2019/sqlite-autoconf-3300000.tar.gz && \
tar xvf sqlite-autoconf-3300000.tar.gz && \
cd sqlite-autoconf-3300000 && \
./configure --prefix=/usr/local --enable-readline | tee log && \
make -j12 | tee logg && \
make -j12 install | tee loggg

#python install
RUN cd /usr/local/src && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
chown -R root:root Python-3.7.4 && \
cd Python-3.7.4 && \
./configure --enable-shared --with-ensurepip=install && \
make -j12 && \
make -j12 install

#perl install
RUN cd /usr/local/src && curl -LO https://www.cpan.org/src/5.0/perl-5.30.0.tar.gz && \
tar -xzf perl-5.30.0.tar.gz && \
cd perl-5.30.0 && \
./Configure -des -Dprefix=/usr/local/ -Duseshrplib && \
make -j12 && \
make -j12 install

#実行ユーザをsqliteに変更
USER sqlite

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

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc && \
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> ~/.bashrc && \
echo "alias sqlite=/usr/local/bin/sqlite3" >> ~/.bashrc


#stackコマンドインストール
RUN curl -sSL https://get.haskellstack.org/ | sh

#ghcインストール
RUN cd ~ && curl -LO https://downloads.haskell.org/~ghc/8.8.1/ghc-8.8.1-x86_64-centos7-linux.tar.xz && \
cd ~ && tar -xvf ghc-8.8.1-x86_64-centos7-linux.tar.xz && \
cd ghc-8.8.1 &&\
./configure --prefix=/usr/local | tee log &&\
sudo make -j12 install | tee logg

#egisonインストール
#15分くらいかかる
RUN sudo yum -y install https://git.io/egison.x86_64.rpm && \
stack install egison

WORKDIR /home/sqlite
