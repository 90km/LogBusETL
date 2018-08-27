#!/bin/bash

export LOG_DIR=/data/logbuslog

#dd=`date -d last-day +%Y%m%d`
dd=`date +%Y%m%d`
YEAR=${dd:0:4}
MONTH=${dd:4:2}
DAY=${dd:6:2}

echo "" && echo "`date`    **** move convert file to logbuslog directory ****"

cd /data/$YEAR

# log file and convert file 
LOG_FILE_COV=log.eu.${YEAR}-${MONTH}-${DAY}_*_cov

mv $LOG_FILE_COV $LOG_DIR
echo "---> mv $LOG_FILE_COV $LOG_DIR"
