#!/bin/bash

declare -a array
array=("login" "account" "charge" "consume" "create" "event" "income" "item" "level" "online" "props" "vip")
#array=("login") 
for event in ${array[@]}
do
    echo "" && echo "`date`    **** deal ${event} log ****" >>/home/centos/logbus/scripts/eventDaily.log
    sh /home/centos/logbus/scripts/templateHistory.sh ${event} >>/home/centos/logbus/scripts/eventDaily.log 2>&1
done                                                                                  
