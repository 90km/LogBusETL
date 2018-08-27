#!/bin/bash

declare -a array
array=("login")
for event in ${array[@]}
do
    echo "" && echo "`date`    **** deal ${event} log ****" >>eventDaily.log
    sh template.sh ${event} >>eventDaily.log 2>&1
done                                                                                  
