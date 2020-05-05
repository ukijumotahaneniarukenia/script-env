- インストーラの配置先は
```
/usr/local/src
```

```
cd /usr/local/src
tar xvf  eclipse-inst-linux64.tar.gz
cd eclipse-installer/
/usr/local/src/eclipse-installer/eclipse-inst 1>launch-eclipse-installer.log 2>&1 &
```

- 実行バイナリがインストールされたあと

```
/usr/local/src/eclipse/eclipse 1>launch-eclipse.log 2>&1 &
```
