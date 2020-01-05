# dockerイメージ作成

```
time docker build -t centos_tcl . | tee log
```

# dockerコンテナ作成 

```
docker run --name tcl -itd centos_tcl
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it tcl /bin/bash
```
