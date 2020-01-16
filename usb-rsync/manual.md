# 参考文献

http://hro-blog.blogspot.com/2016/02/linuxusb.html
https://qiita.com/miyamotok0105/items/2baf80cf1c300503bf5d

基本rootユーザーで作業

# マシンにusbを差し込む

# usbのデバイス名を確認する

# パーテションALL削除

洗い替えの運用のみ

# パーティション作成

```
$fdisk /dev/sda1
Welcome to fdisk (util-linux 2.23.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


コマンド (m でヘルプ): p

Disk /dev/sda1: 7758 MB, 7758955008 bytes, 15154209 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O サイズ (最小 / 推奨): 512 バイト / 512 バイト
Disk label type: dos
ディスク識別子: 0x6e697373

デバイス ブート      始点        終点     ブロック   Id  システム

コマンド (m でヘルプ): n
Partition type:
   p   primary (0 primary, 0 extended, 4 free)
   e   extended
Select (default p): p
パーティション番号 (1-4, default 1): 1
最初 sector (2048-15154208, 初期値 2048): 
初期値 2048 を使います
Last sector, +sectors or +size{K,M,G} (2048-15154208, 初期値 15154208): 
初期値 15154208 を使います
Partition 1 of type Linux and of size 7.2 GiB is set

コマンド (m でヘルプ): p

Disk /dev/sda1: 7758 MB, 7758955008 bytes, 15154209 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O サイズ (最小 / 推奨): 512 バイト / 512 バイト
Disk label type: dos
ディスク識別子: 0x6e697373

デバイス ブート      始点        終点     ブロック   Id  システム
/dev/sda1p1            2048    15154208     7576080+  83  Linux

コマンド (m でヘルプ): w
パーティションテーブルは変更されました！

ioctl() を呼び出してパーティションテーブルを再読込みします。

WARNING: Re-reading the partition table failed with error 22: 無効な引数です.
The kernel still uses the old table. The new table will be used at
the next reboot or after you run partprobe(8) or kpartx(8)
ディスクを同期しています。
```


作成されているか確認

```
[root💜centos (金  1月 17 07:45:41) /home/aine/script_env/java]$fdisk -l

Disk /dev/nvme0n1: 500.1 GB, 500107862016 bytes, 976773168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O サイズ (最小 / 推奨): 512 バイト / 512 バイト
Disk label type: dos
ディスク識別子: 0x000114a2

  デバイス ブート      始点        終点     ブロック   Id  システム
/dev/nvme0n1p1   *        2048     7813119     3905536   83  Linux
/dev/nvme0n1p2         7813120    15624191     3905536   82  Linux swap / Solaris
/dev/nvme0n1p3        15624192   976758783   480567296   83  Linux

Disk /dev/sda: 7759 MB, 7759462400 bytes, 15155200 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O サイズ (最小 / 推奨): 512 バイト / 512 バイト
Disk label type: dos
ディスク識別子: 0x04330c43

デバイス ブート      始点        終点     ブロック   Id  システム
/dev/sda1              63    15154271     7577104+   7  HPFS/NTFS/exFAT
```

# ファイルシステムタイプを変更


基本 ext4で。

```
$mkfs.ext4 /dev/sda1
mke2fs 1.42.9 (28-Dec-2013)
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
474208 inodes, 1894276 blocks
94713 blocks (5.00%) reserved for the super user
First data block=0
Maximum filesystem blocks=1939865600
58 block groups
32768 blocks per group, 32768 fragments per group
8176 inodes per group
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done 


```

# デバイスをマウント

ファイルシステムから操作できることを確認

```
$mount -t ext4 -w /dev/sda1 /mnt/usb1
$ls -la /mnt/usb1
合計 24
drwxr-xr-x. 3 root root  4096  1月 17 07:57 .
drwxr-xr-x. 3 root root  4096  1月 17 07:51 ..
drwx------. 2 root root 16384  1月 17 07:57 lost+found
```

# コピー元ディレクトリを/mntに作成

マウント先ディレクトリの一つ上からはusb1と表示される

```
$cd /mnt
$mkdir cp-src
$ll
合計 8
drwxr-xr-x. 2 root root 4096  1月 17 08:00 cp-src
drwxr-xr-x. 3 root root 4096  1月 17 07:57 usb1
```

# コピー元ディレクトリにコピー物を集める

```
$find /home/aine/Dow* -type f | grep 履歴書 | grep -v テンプレート | xargs -I@ cp @ /mnt/cp-src/
```

# rsyncでコピー


コピー前
```
$tree
.
|-- cp-src
|   |-- \350\201\267\345\213\231\345\261\245\346\255\264\346\233\270.pdf
|   `-- \345\261\245\346\255\264\346\233\270.pdf
`-- usb1
    `-- lost+found

3 directories, 2 files
```


コピー
```
$rsync -av cp-src usb1
sending incremental file list
cp-src/
cp-src/履歴書.pdf
cp-src/職務履歴書.pdf

sent 227,496 bytes  received 58 bytes  455,108.00 bytes/sec
total size is 227,245  speedup is 1.00
```

コピー後
```
$tree
.
|-- cp-src
|   |-- \350\201\267\345\213\231\345\261\245\346\255\264\346\233\270.pdf
|   `-- \345\261\245\346\255\264\346\233\270.pdf
`-- usb1
    |-- cp-src
    |   |-- \350\201\267\345\213\231\345\261\245\346\255\264\346\233\270.pdf
    |   `-- \345\261\245\346\255\264\346\233\270.pdf
    `-- lost+found

4 directories, 4 files
```
# usbをマシンから外す

# 再び差し込む


# ファイルViewerで確認

コピーしたファイルないしディレクトリが存在しているか確認

