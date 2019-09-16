# 参考文献
https://casualdevelopers.com/tech-tips/how-to-install-and-use-jenkins-on-docker-for-nodejs/
https://jenkins.io/download/
https://pkg.jenkins.io/redhat/
https://wiki.jenkins.io/display/JENKINS/Installing+Jenkins+on+Red+Hat+distributions
https://unix.stackexchange.com/questions/9314/no-such-file-or-directory-etc-init-d-functions

# nodeアプリ参考文献
https://casualdevelopers.com/tech-tips/how-to-install-and-use-jenkins-on-docker-for-nodejs/#Jenkins-3
https://casualdevelopers.com/tech-tips/how-to-install-and-use-jenkins-on-docker-for-nodejs/
http://tech-blog.rakus.co.jp/entry/2018/03/05/094238#%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89
https://github.com/ryo-ohnishi/node_express_nginx
https://qiita.com/ryo-ohnishi/items/b54e649b14b51694ef77
https://qiita.com/ryo-ohnishi/items/3653f7583c8591eef333

# jenkins
初期パスワード
```
[root@846e8d2f1f3c jenkins]# pwd
/var/log/jenkins
[root@846e8d2f1f3c jenkins]# grep -C 15 "/var/lib/jenkins/secrets/initialAdminPassword" jenkins.log
INFO: Bean factory for application context [org.springframework.web.context.support.StaticWebApplicationContext@6a124227]: org.springframework.beans.factory.support.DefaultListableBeanFactory@419d889c
Sep 14, 2019 8:06:33 AM org.springframework.beans.factory.support.DefaultListableBeanFactory preInstantiateSingletons
INFO: Pre-instantiating singletons in org.springframework.beans.factory.support.DefaultListableBeanFactory@419d889c: defining beans [filter,legacy]; root of factory hierarchy
Sep 14, 2019 8:06:33 AM jenkins.install.SetupWizard init
INFO: 

*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

19791b22e7884d64b2e221cdfc9dde57

This may also be found at: /var/lib/jenkins/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************

Sep 14, 2019 8:06:38 AM hudson.model.UpdateSite updateData
INFO: Obtained the latest update center data file for UpdateSource default
Sep 14, 2019 8:06:38 AM hudson.model.DownloadService$Downloadable load
INFO: Obtained the updated data file for hudson.tasks.Maven.MavenInstaller
Sep 14, 2019 8:06:38 AM hudson.util.Retrier start
INFO: Performed the action check updates server successfully at the attempt #1
Sep 14, 2019 8:06:38 AM hudson.model.AsyncPeriodicWork$1 run
INFO: Finished Download metadata. 5,423 ms
Sep 14, 2019 8:06:41 AM hudson.model.UpdateSite updateData
INFO: Obtained the latest update center data file for UpdateSource default


```

# dockerコンテナ作成
```
docker run --privileged --shm-size=8gb --name jenkins -itd -v /run/udev:/run/udev -v /run/systemd:/run/systemd -v /tmp/.X11-unix:/tmp/.X11-unix -v /var/lib/dbus:/var/lib/dbus -v /var/run/dbus:/var/run/dbus -v /etc/machine-id:/etc/machine-id -p 13000:3000 -p 280:80 -p 18080:8080 centos_jenkins /sbin/init
```

# dockerコンテナ潜入
```
docker exec -it jenkins /bin/bash
```
