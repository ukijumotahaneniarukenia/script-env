#!/bin/bash

cd ~/script_env/apache
time docker build --no-cache -t centos_apache . | tee log

#gitignore整備
git clone https://github.com/github/gitignore.git
cd gitignore
#アスタリスクを含まないものを縦連結
grep -L "*" -r *gitignore | xargs cat >>~/script_env/.gitignore
#アスタリスクを含むものを縦連結
grep -l "*" -r *gitignore | xargs cat >>~/script_env/.gitignore
cd ~
#各環境に配備
ls -l ~/script_env | grep -P '^d' | awk '{print $9}' | xargs -I@ echo cp ~/script_env/.gitignore ~/script_env/@/.gitignore | sh

cd ~/script_env
git add .gitignore
git add --all *
git commit -m "環境構築"
#git push -u origin master
