FROM centos:latest

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN chsh -s /bin/bash rstudio
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

#nodeとyarnパッケージ管理コマンドいんすこ
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash - && \
 yum install -y nodejs && \
 yum install -y gcc-c++ make && \
 curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo && \
 yum install -y yarn

#jqコマンドいんすこ
RUN yum install -y epel-release
RUN yum install -y jq

#sshdサービス外部公開ポート
EXPOSE 22

#rstudioサービス外部公開ポート
EXPOSE 8787

CMD ["/sbin/init"]
