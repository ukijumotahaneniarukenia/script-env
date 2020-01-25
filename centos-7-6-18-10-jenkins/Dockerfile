FROM centos:latest

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN groupadd -g 1002 jenkins
RUN useradd -m -g jenkins -u 1002 jenkins
RUN chsh -s /bin/bash jenkins
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'jenkins_pwd' | passwd --stdin jenkins
RUN echo 'jenkins ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#各種コマンドインストール
RUN yum install -y epel-release 
RUN yum install -y R
RUN yum install -y sudo zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel libuuid-devel xz-devel openssl libssl-dev libbz2-dev libreadline-dev libsqlite3-dev libffi-devpandoc nkf iputils net-tools iproute tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc parallel man rlwrap java wget

#No such file or directory /etc/init.d/functionsの対策のためいんすこ
RUN yum install -y initscripts
#jenkinsレポ登録
RUN wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
#jenkinsいんすこ
RUN yum install -y jenkins

#nodeとyarnパッケージ管理コマンドいんすこ
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash - && \
 yum install -y nodejs && \
 yum install -y gcc-c++ make && \
 curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
 yum install -y yarn

#jqコマンドいんすこ
RUN yum install -y jq

#nginxインストール
RUN yum install -y yum-utils
RUN { echo "[nginx]";\
      echo "name=nginx repo";\
      echo "baseurl=https://nginx.org/packages/centos/7/x86_64/";\
      echo "gpgcheck=0";\
      echo "enabled=1";\
    } >> /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx

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

#python install
RUN cd ~ && curl -LO https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tgz && \
tar -zxvf Python-3.7.4.tgz && \
cd Python-3.7.4 && \
./configure && \
make -j12 && \
make -j12 install

#perl install
RUN cd ~ && curl -LO https://www.cpan.org/src/5.0/perl-5.30.0.tar.gz && \
tar -xzf perl-5.30.0.tar.gz && \
cd perl-5.30.0 && \
./Configure -des -Dprefix=/usr/local/ && \
make -j12 && \
make -j12 install

#parallelコマンド install
RUN cd ~ && yum install -y bzip2 && curl -LO http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 && \
tar jxf parallel-latest.tar.bz2 && \
cd parallel-20190822 && \
./configure && \
make -j12 && \
make -j12 install

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc

#実行ユーザをrstudioに変更
USER rstudio

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
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc

#実行ユーザをjenkinsに変更
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

#komodoエディタいんすこ
COPY Komodo-IDE-11.1.1-91089-linux-x86_64.tar.gz /home/jenkins/Komodo-IDE-11.1.1-91089-linux-x86_64.tar.gz
RUN cd ~ && tar -xzf Komodo-IDE-11.1.1-91089-linux-x86_64.tar.gz
RUN sudo ln -fsr "/home/jenkins/Komodo-IDE-11/bin/komodo" /usr/local/bin/komodo

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc && \
echo "alias komodo=\"komodo > ~/launch_komodo.log 2>&1 &\"" >> ~/.bashrc && \
echo "export PATH=\"/home/jenkins/Komodo-IDE-11/bin:$PATH\"" >> ~/.bashrc

USER root

#各種X関連コマンドインストール
RUN yum install -y xeyes xorg-x11-server-utils xterm xorg-x11-apps

RUN yum install -y java firefox

#Xwindowシステムパッケージいんすこ
RUN yum -y groupinstall "X Window System"
#以下の対応のためインストール
#Gtk-Message: 23:27:11.098: Failed to load module "pk-gtk-module"
RUN yum install -y PackageKit-gtk3-module

#日本語フォントいんすこ
RUN yum install -y vlgothic-*
RUN yum install -y fcitx ibus

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#nodeサービス外部公開ポート
EXPOSE 3000

#nginxサービス外部公開ポート
EXPOSE 80

#jenkinsサービス外部公開ポート
EXPOSE 8080

#XクライアントがXサーバーにGUI転送出来るように、転送先のIPを指定する
ENV DISPLAY=:0.0
