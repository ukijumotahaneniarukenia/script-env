FROM centos/systemd

#ユーザー作成

#texコマンドインストール
RUN cd /usr/local/src && \
curl -LO http://www.ring.gr.jp/pub/text/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
tar xvf install-tl-unx.tar.gz && \
yum install -y perl-Digest-MD5 && \
cd install-tl-20200129 && \
echo 'I' | ./install-tl

WORKDIR /home/kuraine
