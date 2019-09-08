FROM centos:latest

#nginxインストール
RUN { echo "[nginx]";\
      echo "name=nginx repo";\
      echo "baseurl=https://nginx.org/packages/centos/7/x86_64/";\
      echo "gpgcheck=0";\
      echo "enabled=1";\
    } >> /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx

#fluentdインストール
RUN { echo "[treasuredata]";\
      echo "name=TreasureData";\
      echo "baseurl=http://packages.treasuredata.com/3/redhat/7/x86_64";\
      echo "gpgcheck=1";\
      echo "gpgkey=https://packages.treasuredata.com/GPG-KEY-td-agent";\
    } >> /etc/yum.repos.d/td.repo
RUN yum install -y td-agent

CMD ["/sbin/init"]
