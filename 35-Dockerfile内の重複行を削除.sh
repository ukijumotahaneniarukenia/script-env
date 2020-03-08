#!/bin/bash

while read tgt;do
  echo "echo $HOME/script-env/$tgt/Dockerfile"
  echo "cd  $HOME/script-env/$tgt && uniq Dockerfile>Dockerfile.$$"
  echo "cd  $HOME/script-env/$tgt && diff Dockerfile*"
  echo "cd  $HOME/script-env/$tgt && mv Dockerfile.$$ Dockerfile"
done < <(ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-log) | bash
