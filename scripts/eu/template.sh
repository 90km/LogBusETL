#!/bin/bash

export EVENT_NAME=$1
export ETL_JAR=/home/centos/logbus/jars/LogBusETL.jar
export LOG_DIR=/data/logbuslog
#export LOG_DIR=/home/centos/longsl

# get current year month day
#dd=`date -d last-day +%Y%m%d`
dd=`date +%Y%m%d`
YEAR=${dd:0:4}
MONTH=${dd:4:2}
DAY=${dd:6:2}
#DAY=05

# Enter related directory
cd /data/$YEAR

# delete gzFile on this day
echo "First delete ${YEAR}-${MONTH}-${DAY}_*.gz"
rm ${YEAR}-${MONTH}-${DAY}_*.gz

# download the related log in the day
s3cmd get --force s3://kp-aws-logs-eu/kp-logs/eu/${EVENT_NAME}/${YEAR}/${MONTH}/${DAY}/*
echo "---> s3cmd get --force s3://kp-aws-logs-eu/kp-logs/eu/${EVENT_NAME}/${YEAR}/${MONTH}/${DAY}/*"

# Convert log file 
LOG_FILE=log.eu.${YEAR}-${MONTH}-${DAY}_${EVENT_NAME}
LOG_FILE_COV=log.eu.${YEAR}-${MONTH}-${DAY}_${EVENT_NAME}_cov

#echo $LOG_FILE
#echo $LOG_FILE_COV

# gzip uncompress log .gz file
gzip -dc ${YEAR}-${MONTH}-${DAY}_*.gz >$LOG_FILE
echo "---> gzip -dc ${YEAR}-${MONTH}-${DAY}_*.gz >$LOG_FILE"

# ETL log file by jar
java -jar $ETL_JAR ${EVENT_NAME} $LOG_FILE $LOG_FILE_COV
echo "---> java -jar ${EVENT_NAME} $ETL_JAR $LOG_FILE $LOG_FILE_COV"

#mv $LOG_FILE_COV $LOG_DIR
#echo "---> mv $LOG_FILE_COV $LOG_DIR"

# remove file
rm ${YEAR}-${MONTH}-${DAY}_*.gz $LOG_FILE
echo "---> rm ${YEAR}-${MONTH}-${DAY}_*.gz $LOG_FILE"
