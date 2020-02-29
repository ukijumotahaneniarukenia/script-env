#!/bin/bash

ls -l $HOME/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo mv $HOME/script-env/@/manual.md $HOME/script-env/@/man.md
