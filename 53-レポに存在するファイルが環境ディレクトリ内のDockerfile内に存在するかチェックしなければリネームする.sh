#!/bin/bash


#perl使う予定

#Dockerfileないのスクリプト名を正規化

#バージョン情報を抽出

find $HOME/script-env -name "env-build-arg.md" | while read tgt;do echo $tgt;grep VERSION $tgt;done

#Dockerfile内のVERSIONを抽出した内容で置換


#repoからファイル抽出
#find $HOME/script-repo -type f | grep -vP '\.git|md$'

