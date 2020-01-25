FROM centos/systemd

RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#各種コマンドインストール
RUN yum install -y epel-release
RUN yum install -y sudo git make expect openssh-server openssh-clients

USER kuraine

#sshdサービス外部公開ポート
EXPOSE 22

CMD ["/usr/sbin/init"]
