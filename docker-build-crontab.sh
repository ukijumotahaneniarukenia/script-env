#!/bin/bash

cd /home/aine/script_env/apache

time docker build --no-cache -t centos_apache . | tee log
