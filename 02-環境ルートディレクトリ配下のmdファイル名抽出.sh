#!/bin/bash

find $HOME/script-env -name "*md" | grep -vP '(-[0-9]){1,}' | perl -pe 's;.*/;;g'
