#!/bin/bash
file=$1
if [ ! -f $file ]
then 
	echo "file does not exist"
else
	echo "file exist"
fi
