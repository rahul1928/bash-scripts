#!/bin/bash
filename=$1
linecount=$2

if [ -f $filename ]
then 
echo "file exist"

	total_lines=`cat $filename | wc -l`

	if  [ ${linecount} -gt ${total_lines} ]
	then
                echo "line not found"
                exit
else
	sed -n "$linecount"p $filename
	echo "line found"
	fi

fi
