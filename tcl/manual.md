# Dockerfileよりイメージ作成

```
time docker build -t centos_tcl . | tee log
```

# dockerコンテナ作成 

```
docker run --privileged -v $(pwd):/home/tcl --name tcl -itd centos_tcl
```

# dockerコンテナ潜入

```
docker exec --user tcl -it tcl bash
```
