FROM centos/systemd

#ユーザー作成
RUN groupadd -g 1001 kuraine && \
useradd -m -g kuraine -u 1001 kuraine && \
chsh -s /bin/bash kuraine && \
echo 'kuraine_pwd' | passwd --stdin kuraine && \
echo 'kuraine ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN echo 'root_pwd' | passwd --stdin root

#texコマンドインストール
RUN cd /usr/local/src && \
curl -LO http://www.ring.gr.jp/pub/text/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
tar xvf install-tl-unx.tar.gz && \
yum install -y perl-Digest-MD5 && \
cd install-tl-20200129 && \
echo 'I' | ./install-tl

WORKDIR /home/kuraine
