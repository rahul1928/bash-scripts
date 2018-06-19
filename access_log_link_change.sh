#!/bin/bash
BASE_PATH='/srv/tomcat/server/logs'
file_name="${BASE_PATH}/localhost_access_log.`date +%Y-%m-%d`.txt"
#file_name="${BASE_PATH}/localhost_access_log.2016-11-11.txt"
unlink ${BASE_PATH}/localhost_access_log
ln -s "${file_name}" ${BASE_PATH}/localhost_access_log
while :
do
if [ ! -e "${BASE_PATH}/localhost_access_log" ] ; then
    echo "Link not created successfully"
    echo "Trying again and sleeping for 10 seconds.."
    unlink ${BASE_PATH}/localhost_access_log
    ln -s "${file_name}" ${BASE_PATH}/localhost_access_log
    sleep 10
else
    echo "Link created successfully"
    break
fi
done
