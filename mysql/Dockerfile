FROM centos:latest

RUN yum install -y https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
RUN yum install -y mysql-community-server

# ログのタイムゾーンの設定（初期値：UTC）
RUN echo log_timestamps=SYSTEM >> /etc/my.cnf
# クライアントの文字セットの設定を無視する
RUN echo skip-character-set-client-handshake >> /etc/my.cnf
# デフォルトの文字セット（初期値：utf8mb4 >= 8.0.1）
RUN echo character-set-server=utf8mb4 >> /etc/my.cnf
# タイムスタンプのデフォルト値に関する設定（初期値：ON >= 8.0.2）
RUN echo explicit_defaults_for_timestamp=ON >> /etc/my.cnf

CMD ["/sbin/init"]
