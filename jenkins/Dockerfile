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

#jenkinsサービス外部公開ポート
EXPOSE 8080
