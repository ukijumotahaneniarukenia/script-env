# dockerイメージ作成

```
time docker build -t centos-7-6-18-10-jupyter . | tee log
```

# dockerコンテナ作成

```
docker run --privileged --shm-size=8gb -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -v /etc/localtime:/etc/localtime -p 8888:8888 -itd --name centos-7-6-18-10-jupyter centos-7-6-18-10-jupyter
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it centos-7-6-18-10-jupyter /bin/bash
```

# 参考文献

https://qiita.com/taka4sato/items/2c3397ff34c440044978</br>
https://qiita.com/tand826/items/0c478bf63ead75427782</br>
https://code-graffiti.com/how-to-use-jupyter-notebook/#toc6</br>


# バージョン確認

```
$python3 --version
Python 3.7.4
$ pip3 -V
pip 19.3.1 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
```

# ライブラリインストール 

pipコマンド経由で各ライブラリをいんすこ

ライブラリのインストールはrootユーザーで実行

```
$pip3 install numpy pandas matplotlib seaborn scikit-learn plotly ipython[notebook]
```

# jupyterコマンド確認

```
$ jupyter --version
jupyter core     : 4.6.1
jupyter-notebook : 6.0.2
qtconsole        : not installed
ipython          : 7.11.1
ipykernel        : 5.1.3
jupyter client   : 5.3.4
jupyter lab      : not installed
nbconvert        : 5.6.1
ipywidgets       : 7.5.1
nbformat         : 4.4.0
traitlets        : 4.3.3
```

# jupyter notebook起動

rootユーザー以外で実行

```
$ jupyter notebook --port 8888 --ip=0.0.0.0 1>launch_jupyter.log 2>&1 &
[1] 278
```

起動するとfirefoxが立ち上がる。

ログの一部
```
[I 17:09:23.749 NotebookApp] Writing notebook server cookie secret to /home/kuraine/.local/share/jupyter/runtime/notebook_cookie_secret
[I 17:09:23.882 NotebookApp] Serving notebooks from local directory: /home/kuraine
[I 17:09:23.882 NotebookApp] The Jupyter Notebook is running at:
[I 17:09:23.882 NotebookApp] http://eb796c05a8c5:8888/?token=802f5781499bc6449a86b562baa5571ed1d7760ec8f016ce
[I 17:09:23.882 NotebookApp]  or http://127.0.0.1:8888/?token=802f5781499bc6449a86b562baa5571ed1d7760ec8f016ce
[I 17:09:23.882 NotebookApp] Use Control-C to stop this server and shut down all kernels (twice to skip confirmation).
[C 17:09:23.907 NotebookApp] 
    
    To access the notebook, open this file in a browser:
        file:///home/kuraine/.local/share/jupyter/runtime/nbserver-278-open.html
    Or copy and paste one of these URLs:
        http://eb796c05a8c5:8888/?token=802f5781499bc6449a86b562baa5571ed1d7760ec8f016ce
     or http://127.0.0.1:8888/?token=802f5781499bc6449a86b562baa5571ed1d7760ec8f016ce
START /usr/bin/firefox "/home/kuraine/.local/share/jupyter/runtime/nbserver-278-open.html"
Running without a11y support!
```

ブラウザ経由で作業する場合はサーバーから発行されたトークンを元に実施

# 作業ブック保存


ブラウザでの作業結果を保存すると、ローカルホストのサーバーでは以下のようにファイルが保存される。

Untitled.ipynbがあると前回の作業分から実施できる。

```
[kuraine@eb796c05a8c5 ~]$ pwd
/home/kuraine
[kuraine@eb796c05a8c5 ~]$ ll
total 8
-rw-rw-r--. 1 kuraine kuraine  848  1月  4 17:17 Untitled.ipynb
-rw-rw-r--. 1 kuraine kuraine 1443  1月  4 17:17 launch_jupyter.log
[kuraine@eb796c05a8c5 ~]$ 
```


ログにはこんな感じででる。

```
[I 17:17:20.501 NotebookApp] Creating new notebook in 
[I 17:17:20.535 NotebookApp] Writing notebook-signing key to /home/kuraine/.local/share/jupyter/notebook_secret
[I 17:17:21.102 NotebookApp] Kernel started: 0143cd50-aea8-43df-b248-1ff41696e018
[I 17:17:34.441 NotebookApp] Saving file at /Untitled.ipynb
```

■ブラウザ閉じる

ログにはこんな感じででる。

```
[Parent 402, Gecko_IOThread] WARNING: pipe error (77): Connection reset by peer: file /builddir/build/BUILD/firefox-68.3.0/ipc/chromium/src/chrome/common/ipc_channel_posix.cc, line 358
[Parent 402, Gecko_IOThread] WARNING: pipe error (108): Connection reset by peer: file /builddir/build/BUILD/firefox-68.3.0/ipc/chromium/src/chrome/common/ipc_channel_posix.cc, line 358
[Parent 402, Gecko_IOThread] WARNING: pipe error (95): Connection reset by peer: file /builddir/build/BUILD/firefox-68.3.0/ipc/chromium/src/chrome/common/ipc_channel_posix.cc, line 358
```
