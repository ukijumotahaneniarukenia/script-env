#!/bin/bash

ls ~/script-sketch | grep -vP '(sh|md|log|crontab)$' | grep -vP '^[0-9]{1,}'
