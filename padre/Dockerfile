FROM ubuntu:latest

#各種コマンドインストール
RUN apt-get update
RUN apt-get install -y sudo
#RUN apt-get install -y epel-release#入らない
RUN apt-get install -y nkf
RUN apt-get install -y git
RUN apt-get install -y tree
#RUN apt-get install -y iputils#入らない
RUN apt-get install -y traceroute
RUN apt-get install -y net-tools
RUN apt-get install -y lsof
RUN apt-get install -y make
RUN apt-get install -y gcc
RUN apt-get install -y man
RUN apt-get install -y openssl
RUN apt-get install -y curl

#ユーザー作成
RUN groupadd -g 1001 serena
RUN useradd -m -g serena -u 1001 perl
RUN echo perl:perl_pwd | chpasswd
RUN echo root:root_pwd | chpasswd
RUN echo '%serena ALL=(ALL)       ALL' >> /etc/sudoers
RUN echo 'perl ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#perl パッケージ管理cpanmないしcpanインストール
RUN apt-get install -y build-essential cpanminus libssl-dev 

#Tukubaiコマンドは便利
RUN cd ~ && git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make -j12 install
#
#awkコマンドは最新の奴 include使える
RUN cd ~ && curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make -j12 && \
make -j12 install

##bashも最新
RUN cd ~ && curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
tar -zxvf bash-5.0.tar.gz && \
cd bash-5.0 && \
./configure && \
make -j12 && \
make -j12 install

#vimも最新
#RUN apt-get install -y gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel && \
RUN apt-get install -y libxmu-dev libgtk2.0-dev libxpm-dev libncursesw5-dev && \
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
sh installer.sh ~/.vim/bundle

#emojiのinstall
RUN apt-get install -y unzip && mkdir ~/.fonts && cd ~/.fonts && \
curl -LO https://noto-website-2.storage.googleapis.com/pkgs/Noto-unhinted.zip && \
unzip Noto-unhinted.zip && rm Noto-unhinted.zip

#python pip install
RUN apt-get install -y python3.7 python3.7-dev
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3.7

#perl install
RUN cd ~ && curl -LO https://www.cpan.org/src/5.0/perl-5.30.0.tar.gz && \
tar -xzf perl-5.30.0.tar.gz && \
cd perl-5.30.0 && \
./Configure -des -Dprefix=/usr/local/ && \
make -j12 && \
make -j12 install

#parallelコマンド install
RUN cd ~ && apt-get install -y bzip2 && curl -LO http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 && \
tar jxf parallel-latest.tar.bz2 && \
cd parallel-20190822 && \
./configure && \
make -j12 && \
make -j12 install

#alias設定
RUN echo alias python=/usr/bin/python3.7 >> ~/.bashrc && \
echo alias pip=/usr/local/bin/pip3.7 >> ~/.bashrc && \
echo alias perl=/usr/local/bin/perl5.30.0 >> ~/.bashrc && \
echo alias parallel=/usr/local/bin/parallel >> ~/.bashrc 

#実行ユーザをperlに変更
USER perl

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
sh installer.sh ~/.vim/bundle

#emojiのinstall
RUN sudo apt-get install -y unzip && mkdir ~/.fonts && cd ~/.fonts && \
curl -LO https://noto-website-2.storage.googleapis.com/pkgs/Noto-unhinted.zip && \
unzip Noto-unhinted.zip && rm Noto-unhinted.zip

#alias設定
RUN echo alias python=/usr/bin/python3.7 >> ~/.bashrc && \
echo alias pip=/usr/local/bin/pip3.7 >> ~/.bashrc && \
echo alias perl=/usr/local/bin/perl5.30.0 >> ~/.bashrc && \
echo alias parallel=/usr/local/bin/parallel >> ~/.bashrc && \
echo alias vim=sudo vim >> ~/.bashrc && \
echo alias vi=sudo vim >> ~/.bashrc

#最後はrootに戻す
USER root 

#日本語環境と時刻合わせ
RUN apt-get install -y language-pack-ja-base language-pack-ja
RUN locale-gen ja_JP.UTF-8
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#CMD ["/sbin/init"]
