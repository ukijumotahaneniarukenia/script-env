# 参考文献

db2のセットアップマニュアル
- https://www.ibm.com/support/producthub/db2/docs/content/SSEPGG_11.5.0/com.ibm.db2.luw.qb.server.doc/doc/t0008875.html


コミニュティエディションでて、無償で検証つくれるようになったよー
- https://www.ibmbigdatahub.com/blog/simplifying-db2-downloads-help-clients-and-developers-get-started?_ga=2.116263366.1982163311.1579705509-1850039665.1572074127&cm_mc_uid=89503398108915720741268&cm_mc_sid_50200000=74238601579705509031

- https://www.ibm.com/cloud/blog/announcements/ibm-db2-developer-community-edition

開発マニュアル
- https://www.ibm.com/support/knowledgecenter/ja/ssw_ibm_i_71/rzaha/udftable.htm

以下はメモ

```
root@858be2c9f9b1:/# chmod 777 /home/software
root@8bb04c92ca56:/# cd /home/software
root@8bb04c92ca56:/home/software# gunzip *.gz
root@8bb04c92ca56:/home/software# tar -xvf v11.5_linuxx64_dec.tar 
root@8bb04c92ca56:/home/software# rm v11.5_linuxx64_dec.tar 
root@8bb04c92ca56:/home/software# chmod 777 server_dec
root@8bb04c92ca56:/home/software# mv server_dec ibm-db2
root@8bb04c92ca56:/home/software# cd ibm-db2
root@8bb04c92ca56:/home/software/ibm-db2# ./db2prereqcheck -v 11.5.0.0 
apt-get -y install libaio1 zlib1g-dev libnuma-dev libpam0g-dev file gcc make
root@8bb04c92ca56:/home/software/ibm-db2# dpkg --add-architecture i386
root@8bb04c92ca56:/home/software/ibm-db2# apt-get update
root@8bb04c92ca56:/home/software/ibm-db2# apt install -y binutils libaio1 libstdc++6:i386 libpam0g:i386

root@8bb04c92ca56:/home/software/ibm-db2# ./db2prereqcheck -v 11.5.0.0 

==========================================================================

Sun Feb  2 23:38:10 2020
Checking prerequisites for DB2 installation. Version "11.5.0.0". Operating system "Linux" 
   
Validating "Linux distribution " ... 
   Required minimum "UBUNTU" version: "16.04" 
   Actual version: "18.04" 
   Requirement matched. 
   
Validating "kernel level " ... 
   Required minimum operating system kernel level: "3.10.0". 
   Actual operating system kernel level: "3.10.0". 
   Requirement matched. 
   
Validating "C++ Library version " ... 
   Required minimum C++ library: "libstdc++.so.6" 
   Standard C++ library is located in the following directory: "/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25". 
   Actual C++ library: "CXXABI_1.3.1" 
   Requirement matched. 
   

Validating "32 bit version of "libstdc++.so.6" " ... 
   Found the 32 bit "/usr/lib/i386-linux-gnu/libstdc++.so.6" in the following directory "/usr/lib/i386-linux-gnu". 
   Requirement matched. 
   
Validating "libaio.so version " ... 
DBT3553I  The db2prereqcheck utility successfully loaded the libaio.so.1 file. 
   Requirement matched. 
   
Validating "libnuma.so version " ... 
DBT3610I  The db2prereqcheck utility successfully loaded the libnuma.so.1 file. 
   Requirement matched. 
   
Validating "/lib/i386-linux-gnu/libpam.so*" ... 
   Requirement matched. 
DBT3533I  The db2prereqcheck utility has confirmed that all installation prerequisites were met. 


これたたいて
./db2setup

できたレスポンスファイルを使用していんすこ

root@8bb04c92ca56:/home/software/ibm-db2# cp ./db2/linuxamd64/samples/db2server.rsp .
root@8bb04c92ca56:/home/software/ibm-db2# apt install -y vim
root@8bb04c92ca56:/home/software/ibm-db2# chmod u+w db2server.rsp
root@8bb04c92ca56:/home/software/ibm-db2# ./db2setup -r db2server.rsp 


root@b5348375618d:~# ls
db2server.rsp


root@b5348375618d:/home/software/ibm-db2# ./db2setup -r /root/db2server.rsp 

```
