#!/bin/bash

./11-select-script-sketch-name.sh | xargs -I@ echo mkdir -p ~/script-tool/@
./11-select-script-sketch-name.sh | xargs -I@ echo touch ~/script-tool/@/README.md
