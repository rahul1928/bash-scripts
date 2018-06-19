#!/bin/bash
LOG_DIR=$1
FILE_TYPE=$2
date_today=`date "+%Y-%m-%d"`
SCRIPT_LOGS="/tmp/script.log"
echo "Logs for date: ${date_today}" >> ${SCRIPT_LOGS}
files=`find ${LOG_DIR} -type f -mtime +30 -name "${FILE_TYPE}*"`
for file in $files
do 
	rm -fv "${file}" >> ${SCRIPT_LOGS}
done
