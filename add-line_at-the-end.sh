#!/bin/bash
set -x
filename=$1
lineadd=$2

if [ -f $filename ] 
then 
echo "file exist"

	echo "$lineadd" >> $filename
	echo "line added"
else
	echo "file does not exist"

fi



