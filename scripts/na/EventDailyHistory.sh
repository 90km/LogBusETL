#!/bin/bash

declare -a array
array=("login")
for event in ${array[@]}
do
    echo "" && echo "`date`    **** deal ${event} log ****" >>eventDaily.log
    sh templateHistory.sh ${event} >>eventDaily.log
done                                                                                  
