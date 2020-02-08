#!/bin/bash

ls -l ~/script-env | grep -P '^d' | awk '{print $9}' | grep -v docker-build-log | xargs -I@ echo mv ~/script-env/@/manual.md ~/script-env/@/man.md
