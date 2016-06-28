#!/bin/bash
dir=$1
if [ -d $dir ]
then
	rm -r $dir
	echo "removing done"
else 
	echo "dir not exist"
fi
