# dockerイメージ作成

```
time docker build -t centos-7-6-18-10-c-cpp . | tee log
```

# dockerコンテナ起動

```
docker run --shm-size=8gb --name centos-7-6-18-10-c-cpp -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 3306:3306 centos-7-6-18-10-c-cpp
```

# dockerコンテナ潜入

```
docker exec -it centos-7-6-18-10-c-cpp /bin/bash
```

# フォントインストール

```
mkdir -p ~/.fonts
cd ~/.fonts && curl -LO https://github.com/adobe-fonts/source-han-code-jp/archive/2.011.zip
unzip 2.011.zip
cd ~/.fonts && git clone https://github.com/adobe-type-tools/opentype-svg.git
cd source-han-code-jp-2.011
python3 -m venv afdko_env
source afdko_env/bin/activate
pip3 install afdko
cp ../opentype-svg/*.py .
cp -r ../opentype-svg/util .
cp -r ../opentype-svg/imgs .
cp -r ../opentype-svg/fonts .
sed -i 's;addSVGtable.py;~/.fonts/source-han-code-jp-2.011/addsvgtable.py;g' commands.sh
```
