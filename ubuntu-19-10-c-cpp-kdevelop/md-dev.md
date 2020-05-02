実行ユーザーをroot以外にするためにはfuseグループに割付しないとだめ

自動化を視野に入れるとwhoamiを固定で書く必要がありそう💩

```
#https://www.kdevelop.org/download
#https://www.learncpp.com/cpp-tutorial/a3-using-libraries-with-codeblocks/

#https://github.com/AppImage/AppImageKit/wiki/FUSE

$cd /usr/local/src
$wget -O KDevelop.AppImage https://download.kde.org/stable/kdevelop/5.5.0/bin/linux/KDevelop-5.5.0-x86_64.AppImage
$chmod +x KDevelop.AppImage
$mv KDevelop.AppImage /usr/local/bin
$which KDevelop.AppImage
$apt install fuse
$groupadd fuse
$usermod -a -G fuse $(whoami)
$KDevelop.AppImage 1>launch-kdevelop.log 2>&1 &
```
