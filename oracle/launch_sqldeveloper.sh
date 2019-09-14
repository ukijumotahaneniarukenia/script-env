#!/bin/bash

#jdkのパスを標準入力から与えて起動 標準出力とエラー出力をlogに吐くようにして、バッググラウンド起動
cd ~ && echo /usr/java/jdk1.8.0_221-amd64 | /opt/sqldeveloper/sqldeveloper.sh -conf /opt/sqldeveloper/sqldeveloper/bin/sqldeveloper.conf >log_launch_sqldeveloper 2>&1 &
