#!/bin/bash

docker ps -qa | xargs -I@ bash -c 'docker stop @ && docker rm @'
