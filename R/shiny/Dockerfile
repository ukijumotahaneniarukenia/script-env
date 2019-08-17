FROM centos:latest

#epelレポからRインストール
RUN yum install -y epel-release
RUN yum install -y R
RUN yum install -y libcurl-devel openssl-devel libxml2-devel

#shiny-serverインストール
RUN curl -LO https://download3.rstudio.org/centos6.3/x86_64/shiny-server-1.5.9.923-x86_64.rpm && \
yum install -y --nogpgcheck shiny-server-1.5.9.923-x86_64.rpm

#shinyユーザーはshiny-serverのインストールで追加される
RUN yum install -y sudo
RUN echo 'shiny_pwd' | passwd --stdin shiny
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'shiny ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# shinyアプリに必要なパッケージインストール
# https://www.marketechlabo.com/r-best-packages/

RUN echo {shiny,rmarkdown,devtools,dplyr,tidyr,tidyverse,Unicode,stringr,ggplot2,readxl,magrittr,doParallel,purrr,reshape2} | tr ' ' '\n' | xargs -I@ R -e ""'install.packages("@",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 6L))'
#RUN R -e 'install.packages("shiny",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("rmarkdown",repos="http://cran.ism.ac.jp/" , dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("devtools", repos="http://cran.ism.ac.jp/", dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("dplyr",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("tidyr",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("tidyverse",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("Unicode",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("stringr",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("ggplot2",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("readxl",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("magrittr",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("doParallel",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("purrr",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'install.packages("reshape2",repos="http://cran.ism.ac.jp/" ,dependencies = TRUE, Ncpus = getOption("Ncpus", 12L))'
#RUN R -e 'devtools::install_github("hadley/emo")'
#RUN R -e 'devtools::install_github("KosukeHamazaki/RconVerteR")'
#RUN R -e 'devtools::install_github("rstudio/renv")'

##実行ユーザをshinyに変更
USER shiny

#諸々インストール
#ネットワーク系は必須
RUN sudo yum install -y pandoc
RUN sudo yum install -y nkf
RUN sudo yum install -y iputils
RUN sudo yum install -y net-tools
RUN sudo yum install -y iproute
RUN sudo yum install -y vim
RUN sudo yum install -y tree
RUN sudo yum install -y lsof
RUN sudo yum install -y traceroute
RUN sudo yum install -y psmisc
RUN sudo yum install -y bind-utils
RUN sudo yum install -y git
RUN sudo yum install -y make
RUN sudo yum install -y expect
RUN sudo yum install -y openssh-server
RUN sudo yum install -y openssh-clients
RUN sudo yum install -y gcc

#実行ユーザをrootに変更
USER root

#Tukubaiコマンドは便利
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

#vimも最新
RUN git clone https://github.com/vim/vim.git && \
yum install -y ncurses-devel && \
cd vim && \
make -j12 distclean && \
make -j12 && \
make -j12 install

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

#shinyサービスの提供ポートを外部アクセスようにオープンしておく
EXPOSE 3838

# コンテナログイン時のwdを設定
WORKDIR /srv/shiny-server

CMD ["/sbin/init"]
