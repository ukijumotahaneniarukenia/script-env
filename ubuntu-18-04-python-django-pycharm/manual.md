# 参考文献
- https://qiita.com/zaki-lknr/items/b89c35d90df96a000256
- https://qiita.com/homines22/items/2730d26e932554b6fb58

# dockerイメージ作成

```
time docker build -t ubuntu-18-04-python-django-pycharm . | tee log
```

# dockerコンテナ起動

```
docker run --privileged --shm-size=4gb --name ubuntu-18-04-python-django-pycharm -itd -v /etc/localtime:/etc/localtime -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 8000:8000 ubuntu-18-04-python-django-pycharm
```

# dockerコンテナ潜入

```
docker exec -it ubuntu-18-04-python-django-pycharm /bin/bash
```

# pycharm起動

```
$ pyc
[1] 16
$tail ~/launch_pycharm.log
```

# バージョン確認

```
$pip3 install --upgrade pip
$python3 --version
Python 3.7.4
$pip3 -V
pip 20.0.2 from /usr/local/lib/python3.7/site-packages/pip (python 3.7)
```

# djangoいんすこ

```
$pip3 install django
Collecting django
  Downloading Django-3.0.2-py3-none-any.whl (7.4 MB)
     |████████████████████████████████| 7.4 MB 1.9 MB/s
Collecting pytz
  Downloading pytz-2019.3-py2.py3-none-any.whl (509 kB)
     |████████████████████████████████| 509 kB 2.4 MB/s
Collecting sqlparse>=0.2.2
  Downloading sqlparse-0.3.0-py2.py3-none-any.whl (39 kB)
Collecting asgiref~=3.2
  Downloading asgiref-3.2.3-py2.py3-none-any.whl (18 kB)
Installing collected packages: pytz, sqlparse, asgiref, django
Successfully installed asgiref-3.2.3 django-3.0.2 pytz-2019.3 sqlparse-0.3.0
```

# django-adminコマンドによるプロジェクト作成

javaでいうmavenコマンドやgradleコマンド的なやつであろう

```
$find / -name "*django*" 2>/dev/null |& grep bin
/usr/local/bin/django-admin.py
/usr/local/bin/__pycache__/django-admin.cpython-37.pyc
/usr/local/bin/django-admin
/usr/local/lib/python3.7/site-packages/django/bin/django-admin.py
/usr/local/lib/python3.7/site-packages/django/bin/__pycache__/django-admin.cpython-37.pyc
```
