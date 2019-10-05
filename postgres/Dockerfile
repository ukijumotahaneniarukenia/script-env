FROM centos:7.6.1810

#ユーザー作成
RUN echo 'root_pwd' | passwd --stdin root

#レポジトリ登録
RUN yum -y install https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

#epelレポ登録
RUN yum -y install epel-release

#登録したレポジトリからインストール
RUN yum -y install pgadmin4

#サーバモード指定
RUN echo "SERVER_MODE = True" >> /usr/lib/python2.7/site-packages/pgadmin4-web/config_local.py
#外部からのアクセスを可能にする
RUN echo "DEFAULT_SERVER = '0.0.0.0'" >> /usr/lib/python2.7/site-packages/pgadmin4-web/config_local.py
RUN echo "LOG_FILE = '/var/log/pgadmin4/pgadmin4.log'" >> /usr/lib/python2.7/site-packages/pgadmin4-web/config_local.py

#postgres install
#RUN yum -y install postgresql11-server

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo export PATH=$PATH:/usr/pgsql-11/bin >> ~/.bashrc && \
echo export PGSETUP_INITDB_OPTIONS="-E UTF8 --locale=C" 

#実行ユーザをpostgresに変更
USER postgres

# sampleスキーマのフェッチ
RUN cd ~ && curl -LO http://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
RUN cd ~ && sudo yum install -y unzip && unzip dvdrental.zip

#alias設定
RUN echo alias python="/usr/local/bin/python3.7" >> ~/.bashrc && \
echo alias pip="/usr/local/bin/pip3.7" >> ~/.bashrc && \
echo alias perl="/usr/local/bin/perl5.30.0" >> ~/.bashrc && \
echo "alias parallel=\"/usr/local/bin/parallel\"" >> ~/.bashrc && \
echo "alias vim=\"sudo vim\"" >> ~/.bashrc && \
echo "alias vi=\"sudo vim\"" >> ~/.bashrc && \
echo export PATH=$PATH:/usr/pgsql-11/bin >> ~/.bashrc && \
echo export PGSETUP_INITDB_OPTIONS="-E UTF8 --locale=C" 

#最後はrootに戻す
USER root 

#日本語環境と時刻合わせ
RUN yum -y reinstall glibc-common
RUN localedef -v -c -i ja_JP -f UTF-8 ja_JP.UTF-8; echo "";
ENV LANG=ja_JP.UTF-8
RUN rm -f /etc/localtime
RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

#sshdサービス外部公開ポート
EXPOSE 22

#postgresサービス外部公開ポート
EXPOSE 5432

#pgAdminサービス外部公開ポート
EXPOSE 5050
