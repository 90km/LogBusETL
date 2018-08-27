#!/bin/bash

declare -a array
array=("login" "account" "charge" "consume" "create" "event" "income" "item" "level" "online" "props" "vip")
#array=("event")
for event in ${array[@]}
do
    echo "" && echo "`date`    **** deal ${event} log ****" >>/home/centos/logbus/scripts/eventDaily.log
    sh /home/centos/logbus/scripts/template.sh ${event} >>/home/centos/logbus/scripts/eventDaily.log 2>&1
done                                                                                  
