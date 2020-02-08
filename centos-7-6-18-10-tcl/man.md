# dockerイメージ作成

```
time docker build -t centos-7-6-18-10-tcl . | tee log
```

# dockerコンテナ作成

```
docker run --name centos-7-6-18-10-tcl -itd centos-7-6-18-10-tcl
```

# dockerコンテナ潜入

```
docker exec --user kuraine -it centos-7-6-18-10-tcl /bin/bash
```
