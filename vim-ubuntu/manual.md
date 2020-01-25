# dockerコンテナ作成

```
docker run --shm-size=2gb --name vim-ubuntu -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X1-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id vim-ubuntu
```

# dockerイメージ作成

```
time docker build -t vim-ubuntu . | tee log
```

# dockerコンテナ潜入

```
docker exec -it vim-ubuntu /bin/bash
```

# vimビルドに必要なパッケージをインストール

```
$grep '^deb ' /etc/apt/sources.list | sed 's/^deb/deb-src/g' > /etc/apt/sources.list.d/deb-src.list && apt-get update
$apt-get build-dep -y vim
$apt-get install -y python-dev
$apt-get install -y tcl-dev
$apt-get install -y perl5*-dev
```

# vimインストール

ビルドやりなおす場合
```
$ls -l /usr/local/bin | grep -P '^l' | awk '{print $9}' | xargs -I@ echo unlink /usr/local/bin/@ | sh
$make clean distclean
```

python関連でエラー起きる場合
Makefileのある場所を探して
```
$find / -name "*Makefile*" 2>/dev/null | grep python
/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu/Makefile
```

以下のオプションを追加
```
--with-python-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu
```

ビルド
```
cd /usr/local/src && \
git clone https://github.com/vim/vim.git && \
cd vim && \
./configure --with-features=huge --with-x --with-python-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu --enable-multibyte --enable-luainterp=dynamic --enable-gpm --enable-cscope --enable-fontset --enable-fail-if-missing --prefix=/usr/local --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=dynamic --enable-tclinterp=dynamic --enable-perlinterp=dynamic --enable-gui=auto --enable-gtk2-check && \
make -j12 && \
make -j12 install && \
ln -fsr /usr/local/bin/vim /usr/bin/vi
```


# 各言語ごとにプラグインを設定

python環境
```
pip3 install python-language-server
```

c-cpp環境
http://kutimoti.hatenablog.com/entry/2018/05/20/110732
```
apt install -y llvm clang clang-tools
```
