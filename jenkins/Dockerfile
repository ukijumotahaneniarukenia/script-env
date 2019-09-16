FROM centos:latest

RUN yum install -y epel-release
#No such file or directory /etc/init.d/functionsの対策のためいんすこ
RUN yum install -y initscripts
#javaいんすこ
RUN yum install -y java
#jenkinsレポ登録
RUN yum install -y wget
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

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN chsh -s /bin/bash rstudio
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN yum install -y git

#nodeサービス外部公開ポート
EXPOSE 3000

#nginxサービス外部公開ポート
EXPOSE 80

#jenkinsサービス外部公開ポート
EXPOSE 8080
