FROM centos:latest

#rstudioユーザー追加＆serenaグループ追加
#rstudioのユーザーidとグループidは1001でないとダメ絶対
RUN yum install -y sudo
RUN groupadd -g 1001 serena
RUN useradd -m -g serena -u 1001 rstudio
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'root_pwd' | passwd --stdin root
RUN echo '%docker ALL=(ALL)       ALL' >> /etc/sudoers
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#実行ユーザをrstudioに変更
USER rstudio

#epelレポからRインストール
RUN sudo yum install -y epel-release
RUN sudo yum install -y R

#Rstudioインストール
RUN sudo yum install -y --nogpgcheck https://s3.amazonaws.com/rstudio-ide-build/server/centos6/x86_64/rstudio-server-rhel-1.2.1568-x86_64.rpm

#諸々インストール
#ネットワーク系は必須

RUN echo pandoc nkf iputils net-tools iproute vim tree lsof traceroute psmisc bind-utils git make expect openssh-server openssh-clients gcc | tr ' ' '\n' | xargs -I@ sudo yum install -y @

#自身のvim環境をクローン
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim

#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv .vimrc .. && \
#用が済んだらリム
rm -rf ~/tmp

#vimも最新
RUN echo gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel | tr ' ' '\n' | xargs -I@ sudo yum install -y @ && \
git clone https://github.com/vim/vim.git ~/vim && \
cd ~/vim && \
./configure --enable-multibyte --with-features=huge --enable-cscope --enable-gui=gtk2 --disable-selinux --prefix=/usr/local --enable-xim --enable-fontset --enable-gpm --enable-rubyinterp --with-python-config-dir=/usr/lib/python2.7/config && \
sudo make -j12 distclean && \
sudo make -j12 && \
sudo make -j12 install && \
#rootユーザーで張ってるからよろし
#ln -fsr /usr/local/bin/vim /usr/bin/vim && \
#ln -fsr /usr/local/bin/vim /usr/bin/vi && \
mkdir -p ~/.vim/bundle && \
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle

#実行ユーザをrootに変更
USER root

##Tukubaiコマンドは便利
RUN git clone https://github.com/usp-engineers-community/Open-usp-Tukubai.git && \
cd Open-usp-Tukubai && \
make -j12 install

#awkコマンドは最新の奴 include使える
RUN curl -LO ftp://ftp.gnu.org/gnu/gawk/gawk-5.0.0.tar.gz && \
tar -zxvf gawk-5.0.0.tar.gz && \
cd gawk-5.0.0 && \
./configure && \
make -j12 && \
make -j12 install

#bashも最新
RUN curl -LO ftp://ftp.gnu.org/pub/gnu/bash/bash-5.0.tar.gz && \
tar -zxvf bash-5.0.tar.gz && \
cd bash-5.0 && \
./configure && \
make -j12 && \
make -j12 install

#自身のvim環境をクローン
RUN git clone https://github.com/ukijumotahaneniarukenia/.vim.git ~/.vim

#自身の.vimrcをクローンこれをdotfileとかで管理するようになるのかな。
RUN git clone https://github.com/ukijumotahaneniarukenia/dotfile.git ~/tmp && \
cd ~/tmp && \
#移動したいdotfileをchoiceしてHOMEディレクトリへ
mv .vimrc .. && \
#用が済んだらリム
rm -rf ~/tmp

#vimも最新
RUN echo gtk2-devel atk-devel libX11-devel libXt-devel ncurses-devel | tr ' ' '\n' | xargs -I@ yum install -y @ && \
git clone https://github.com/vim/vim.git && \
cd vim && \
./configure --enable-multibyte --with-features=huge --enable-cscope --enable-gui=gtk2 --disable-selinux --prefix=/usr/local --enable-xim --enable-fontset --enable-gpm --enable-rubyinterp --with-python-config-dir=/usr/lib/python2.7/config && \
make -j12 distclean && \
make -j12 && \
make -j12 install && \
ln -fsr /usr/local/bin/vim /usr/bin/vim && \
ln -fsr /usr/local/bin/vim /usr/bin/vi && \
mkdir -p ~/.vim/bundle && \
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
sh installer.sh ~/.vim/bundle

#pythonもそこそこ最新
RUN yum install -y python36 python36-devel python36-libs && \
python3 -m ensurepip && \
pip3 install --upgrade pip

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#alias設定
RUN echo alias python="/usr/bin/python3.6" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip" >> ~/.bashrc

#実行ユーザをrstudioに変更
USER rstudio

#alias設定
RUN echo alias python="/usr/bin/python3.6" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip" >> ~/.bashrc

#Rstudioサービスの提供ポートを外部アクセスようにオープンしておく
EXPOSE 8787

#コンテナログイン時のwdを設定
WORKDIR /home/rstudio

CMD ["/sbin/init"]
