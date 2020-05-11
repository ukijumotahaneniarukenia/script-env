# フォントインストール

- Dockerfileで完結できればいいが、今の所思いつかない。

```
python3: error while loading shared libraries: libpython3.7m.so.1.0: cannot open shared object file: No such file or directory
```

- コンテナ起動後、あたたかみのある手動実行

  - 一般ユーザーで実行

```
mkdir -p ~/.fonts && \
cd ~/.fonts && curl -LO https://github.com/adobe-fonts/source-han-code-jp/archive/2.011.zip && \
unzip 2.011.zip && \
cd ~/.fonts && git clone https://github.com/adobe-type-tools/opentype-svg.git && \
cd source-han-code-jp-2.011 && \
python3 -m venv afdko_env && \
source afdko_env/bin/activate && \
pip3 install afdko && \
cp ../opentype-svg/*.py . && \
cp -r ../opentype-svg/util . && \
cp -r ../opentype-svg/imgs . && \
cp -r ../opentype-svg/fonts . && \
sed -i 's;addSVGtable.py;~/.fonts/source-han-code-jp-2.011/addSVGtable.py;g' commands.sh && \
sed -i 's;for wt in ExtraLight Light Normal Regular Medium Bold Heavy;for wt in ExtraLight Light Normal Medium Bold Heavy;g' commands.sh && \
./commands.sh && \
find ~/.fonts/source-han-code-jp-2.011 -name "*otf" | xargs -I@ cp @ ~/.fonts && \
fc-cache -fv
```
