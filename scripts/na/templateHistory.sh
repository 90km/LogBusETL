#!/bin/bash

export EVENT_NAME=$1
export ETL_JAR=/home/centos/logbus/jars/LogBusETL.jar
export LOG_DIR=/data_bak/logbuslog

# get current year month day
YEAR=`date +%Y`
#MONTH=`date +%m`

declare -a array 
array=(01)
for mon in ${array[@]}
do
MONTH=$mon
#DAY=`date -d last-day +%d`

# 
#cd /tmp
cd /data_bak/2018

# download the login log in the day
echo "############" `date "+%Y-%m-%d %H:%M:%S"` ${EVENT_NAME}事件在${YEAR}-${MONTH}的数据清洗及推送开始 "###############"
echo "---> s3cmd get -fr s3://kp-aws-logs-sg/kp-logs/sg/${EVENT_NAME}/${YEAR}/${MONTH}/*"
s3cmd get -fr s3://kp-aws-logs-sg/kp-logs/sg/${EVENT_NAME}/${YEAR}/${MONTH}

# log file and convert file 
LOG_FILE=log.sg.${YEAR}-${MONTH}_${EVENT_NAME}
LOG_FILE_COV=log.sg.${YEAR}-${MONTH}_${EVENT_NAME}_cov

echo $LOG_FILE
echo $LOG_FILE_COV

# compress month logs 
gzip -dcr ${MONTH}/ >$LOG_FILE
echo "---> gzip -dcr s3://kp-aws-logs-sg/kp-logs/sg/${EVENT_NAME}/${YEAR}/${MONTH}/* >$LOG_FILE"

# ETL log file by jar
java -jar $ETL_JAR ${EVENT_NAME} $LOG_FILE $LOG_FILE_COV
echo "---> java -jar ${EVENT_NAME} $ETL_JAR $LOG_FILE $LOG_FILE_COV"

#mv $LOG_FILE_COV $LOG_DIR
#echo "---> mv $LOG_FILE_COV $LOG_DIR"

# remove logs Dir
rm -r ${MONTH}

# remove file
rm $LOG_FILE
echo "---> rm $MONTH $LOG_FILE"
echo "############"  `date "+%Y-%m-%d %H:%M:%S"` ${EVENT_NAME}事件在${YEAR}-${MONTH}的数据清洗及推送完成 "###############"
done
