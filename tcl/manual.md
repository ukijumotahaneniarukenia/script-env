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


https://www.activestate.com/products/tcl/downloads/
https://wiki.tcl-lang.org/page/emoji

```

tar -xvf ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d.tar.gz
cd ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d
./install.sh | tee log


[root@23dbefd6f3fc ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d]# find . -name "*unicode*"
./pdemos/Tk8.6/unicodeout.tcl
./payload/man/mann/unicode_data.n
./payload/man/mann/unicode.n
./payload/lib/tk8.6/demos/unicodeout.tcl
./payload/lib/tcllib1.18/stringprep/unicode_data.tcl
./payload/lib/tcllib1.18/stringprep/unicode.tcl

Please specify the installation directory.
Accept License [yes] => 'A' >>A
Path [/opt/ActiveTcl-8.6]: /usr/local/src/ActiveTcl-8.6
Press return to begin installation
     Installation Directory:  /usr/local/src/ActiveTcl-8.6
     Demos Directory:         /usr/local/src/ActiveTcl-8.6/demos
     Runtime Directory:       /usr/local

[root@e2fed7f294a2 ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d]# echo PATH="/usr/local/src/ActiveTcl-8.6/bin:$PATH" >>~/.bashrc
[root@e2fed7f294a2 ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d]# echo "export PATH" >>~/.bashrc
[root@e2fed7f294a2 ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d]# source ~/.bashrc


[root@e2fed7f294a2 tcl]# which tclsh
/usr/local/src/ActiveTcl-8.6/bin/tclsh


[root@e2fed7f294a2 tcl]# tclsh
% info tclversion
8.6
```


```
[rootd2d7186ae1e4 (Wed Nov 13 12:09:11) /home/tcl/ActiveTcl-8.6.9.8609.2-x86_64-linux-glibc-2.5-dcd3ff05d]$ln -fsr /usr/local/src/ActiveTcl-8.6/bin/tclsh /usr/local/bin/tclsh

```
