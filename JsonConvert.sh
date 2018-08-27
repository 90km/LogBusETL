#!/bin/bash

# description ：exec remote shell script
# Param ： $1 输入文件, $2 输出文件
# Author : longsl
# Date : 2018-08-14

export input=$1			# 输入文件的路径
export output=$2		# 输出文件的路径

if [ $# != 2 ] ; then
echo "USAGE: ./JsonConvert.sh [JsonFile] [ConvetFile]"
exit 1;
fi

java -jar LogBusETL.jar json $input $output

