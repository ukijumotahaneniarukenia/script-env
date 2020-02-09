- デフォルトのユーザー
```
root@b4207bf41547:/# cat /etc/passwd | grep git
git:x:998:998::/var/opt/gitlab:/bin/sh
gitlab-www:x:999:999::/var/opt/gitlab/nginx:/bin/false
gitlab-redis:x:997:997::/var/opt/gitlab/redis:/bin/false
gitlab-psql:x:996:996::/var/opt/gitlab/postgresql:/bin/sh
mattermost:x:994:994::/var/opt/gitlab/mattermost:/bin/sh
registry:x:993:993::/var/opt/gitlab/registry:/bin/sh
gitlab-prometheus:x:992:992::/var/opt/gitlab/prometheus:/bin/sh
gitlab-consul:x:991:991::/var/opt/gitlab/consul:/bin/sh
```


使いやすいので、もうちょういあしたねばる

- https://www.google.co.jp/amp/s/marunouchi-tech.i-studio.co.jp/3715/%3famp=1

- https://qiita.com/ynott/items/1ff698868ef85e50f5a1

- https://dev.classmethod.jp/ci/gitlab-runner-ci-cd-1/

- https://ngyuki.hatenablog.com/entry/2017/07/07/093326

- http://nyameji.hatenablog.com/entry/2018/02/18/181445

メール送信📩
- https://www.google.com/amp/s/www.yokoweb.net/2016/09/04/ubuntu-gitlab-mail/%3Famp%3D1


```
dockerコンテナにいんすこ

- https://docs.gitlab.com/runner/install/linux-manually.html#using-binary-file


rootユーザーで実行
$curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | bash
$apt install -y gitlab-runner
$systemctl enable gitlab-runner
$systemctl start gitlab-runner


root@c716a392ebaf:~/first-project# ll
total 20
drwxr-xr-x. 3 root root 4096  2月  3 21:33 ./
drwx------. 1 root root 4096  2月  3 21:35 ../
drwxr-xr-x. 7 root root 4096  2月  3 21:33 .git/
-rw-r--r--. 1 root root    0  2月  3 21:33 README.md
root@c716a392ebaf:~/first-project# vim .gitlab-ci.yml
root@c716a392ebaf:~/first-project# vim .gitlab-ci.yml
root@c716a392ebaf:~/first-project# git add .gitlab-ci.yml
root@c716a392ebaf:~/first-project# git commit -m "ci"
[master 179da46] ci
 1 file changed, 7 insertions(+)
 create mode 100644 .gitlab-ci.yml
root@c716a392ebaf:~/first-project# git push -u origin master
Username for 'http://localhost:9010': ukijumotahaneniarukenia
Password for 'http://ukijumotahaneniarukenia@localhost:9010': 
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 353 bytes | 353.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To http://localhost:9010/ukijumotahaneniarukenia/first-project.git
   95491cb..179da46  master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
root@c716a392ebaf:~/first-project# 


root@c716a392ebaf:~/first-project# gitlab-runner register
Runtime platform                                    arch=amd64 os=linux pid=5481 revision=003fe500 version=12.7.1
Running in system-mode.                            
                                                   
Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com/):
http://localhost:9010/
Please enter the gitlab-ci token for this runner:
sp9UxovhRr5vsqE3BHiv
Please enter the gitlab-ci description for this runner:
[c716a392ebaf]: test
Please enter the gitlab-ci tags for this runner (comma separated):
test
Registering runner... succeeded                     runner=sp9Uxovh
Please enter the executor: docker, docker-ssh, parallels, shell, virtualbox, custom, docker+machine, docker-ssh+machine, kubernetes, ssh:
docker
Please enter the default Docker image (e.g. ruby:2.6):
ubuntu-18-04-gitlab:latest
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded! 
root@c716a392ebaf:~/first-project# systemctl restart gitlab-runner
```
