#!/bin/bash

./7-select-app-name.sh | xargs -I@ echo mkdir -p ~/script-sketch/@
