# 参考文献

- https://qiita.com/msakamoto_sf/items/78c322cb8656615ce134

- https://qiita.com/sky_y/items/15bf7737f4b37da50372

# dockerイメージ作成

```
time docker build -t centos-7-6-18-10-tex . | tee log
```

# dockerコンテナ起動

```
docker run --privileged -itd --name centos-7-6-18-10-tex -v /sys/fs/cgroup:/sys/fs/cgroup:ro centos-7-6-18-10-tex
```

# dockerコンテナ潜入

```
docker exec -it centos-7-6-18-10-tex /bin/bash
```
