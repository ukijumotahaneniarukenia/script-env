#!/bin/bash

cd /home/aine/script_env/apache

time docker build --no-cache -t centos_apache . | tee log

cd /home/aine/script_env/fluentd

time docker build --no-cache -t centos_fluentd . | tee log
