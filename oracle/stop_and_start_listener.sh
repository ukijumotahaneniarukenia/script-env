#!/bin/bash
sleep 5
lsnrctl stop
sleep 5
lsnrctl start
sleep 5
lsnrctl status
