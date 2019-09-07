FROM centos:latest

#ユーザー作成
RUN groupadd -g 1001 rstudio
RUN useradd -m -g rstudio -u 1001 rstudio
RUN groupadd -g 1002 elasticsearch
RUN useradd -m -g elasticsearch -u 1002 elasticsearch
RUN groupadd -g 1003 kibana
RUN useradd -m -g kibana -u 1003 kibana
RUN chsh -s /bin/bash rstudio
RUN chsh -s /bin/bash elasticsearch 
RUN chsh -s /bin/bash kibana
RUN echo 'root_pwd' | passwd --stdin root
RUN echo 'rstudio_pwd' | passwd --stdin rstudio
RUN echo 'rstudio ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'elasticsearch_pwd' | passwd --stdin elasticsearch
RUN echo 'elasticsearch ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN echo 'kibana_pwd' | passwd --stdin kibana
RUN echo 'kibana ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN yum install -y java-11-openjdk-devel-11.0.4.11-0.el7_6.i686
RUN { echo "[elasticsearch-7.x]"; \
      echo "name=Elasticsearch repository for 7.x packages"; \
      echo "baseurl=https://artifacts.elastic.co/packages/7.x/yum"; \
      echo "gpgcheck=1"; \
      echo "gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch"; \
      echo "enabled=1"; \
      echo "autorefresh=1"; \
      echo "type=rpm-md"; \
    } >> /etc/yum.repos.d/elasticsearch.repo 
RUN yum install -y elasticsearch

RUN yum install -y kibana
RUN yum install -y net-tools iproute lsof
RUN sed -i 's;#server.port: 5601;server.port: 5601;' /etc/kibana/kibana.yml
RUN ( IP=$(ifconfig eth0 | grep inet | sed -E 's;\s{1,}; ;' | cut -d" " -f 3) && sed -i "s;#server.host: \"localhost\";server.host: \"$IP\";" /etc/kibana/kibana.yml )

#elasticサービス外部公開ポート
EXPOSE 9200

#kibanaサービス外部公開ポート
EXPOSE 5601

CMD ["/sbin/init"]
