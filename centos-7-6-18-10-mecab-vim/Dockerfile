#mecabコマンドインストール
COPY mecab-0.996.tar.gz /usr/local/src/mecab-0.996.tar.gz
RUN cd /usr/local/src && tar xvf mecab-0.996.tar.gz && \
cd mecab-0.996 && \
./configure && \
make -j12 && \
make -j12 install
