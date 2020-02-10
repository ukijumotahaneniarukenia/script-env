#!/bin/bash

#ディレクトリ作成。ファイルはそのまま残ってる。
ls ~/script-env | grep -vP '(sh|md|log|crontab)$' | grep -vP '^[0-9]{1,}' | xargs -I@ echo mkdir -p ~/script-scratch/@
#新規ファイル作成。
ls ~/script-env | grep -vP '(sh|md|log|crontab)$' | grep -vP '^[0-9]{1,}' | xargs -I@ echo touch ~/script-scratch/@/README.md
